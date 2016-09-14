class PiecesController < ApplicationController

  helper_method :sort_colours_in_array

  # load_and_authorize_resource

  COLOURS = ['red', 'orange', 'yellow', 'taupe', 'lime', 'green', 'teal', 'blue', 'navy', 'purple', 'pink', 'brown', 'grey', 'silver', 'black', 'white']

  def index

    if user_signed_in?
      @pieces = Piece.where("end_date >= '#{Time.zone.now.beginning_of_day}'").not_owned_by(current_user.id).order_by_new
    else
      @pieces = Piece.all.where("end_date >= '#{Time.zone.now.beginning_of_day}'").order_by_new
    end
    # @pieces = @pieces.where("end_date >= #{Time.zone.now.beginning_of_day}")
    @colours_in_unfiltered_pieces = @pieces.sort_colours_in_collection(@pieces)
    @sizes_in_unfiltered_pieces = @pieces.map{ |i| i[:size] }.uniq.sort

    @pieces = @pieces.coloursearch(params[:colour]) if params[:colour].present?
    @pieces = @pieces.sizesearch(params[:size]) if params[:size].present?
    @pieces = @pieces.are_available_now? if params[:available].present? && params[:available] == true.to_s
    @pieces = @pieces.sort_by { |item| item[:id] }.reverse
    authorize! :read, @pieces
  end

  def owned
    @pieces = current_user.pieces.where("end_date >= '#{Time.zone.now.beginning_of_day}'")
    @colours_in_unfiltered_pieces = @pieces.sort_colours_in_collection(@pieces)
    @sizes_in_unfiltered_pieces = @pieces.map{ |i| i[:size] }.uniq.sort
    authorize! :read, @pieces
    render 'index'
  end

  def hearted
    @pieces = Piece.where("end_date >= '#{Time.zone.now.beginning_of_day}'")
    @pieces = @pieces.select{|i| i.heart.users.ids.include? current_user.id }

    colours = @pieces.map{ |i| i[:colour] }.uniq
    sorted_colourlist = []
    COLOURS.map { |col|   (sorted_colourlist << col) if colours.include? col }
    @colours_in_unfiltered_pieces = sorted_colourlist

    @sizes_in_unfiltered_pieces = @pieces.map{ |i| i[:size] }.uniq.sort
    authorize! :read, @pieces
    render 'index'
  end

  def type
    authorize! :read, @pieces

    @pieces = Piece.where(product_type: params[:product_type])
    @pieces = @pieces.where("end_date >= '#{Time.zone.now.beginning_of_day}'")

    colours = @pieces.map{ |i| i[:colour] }.uniq
    sorted_colourlist = []
    COLOURS.map { |col|   (sorted_colourlist << col) if colours.include? col }
    @colours_in_unfiltered_pieces = sorted_colourlist

    @sizes_in_unfiltered_pieces = @pieces.map{ |i| i[:size] }.uniq.sort
    @pieces = @pieces.are_available_now? if params[:available].present? && params[:available] == true.to_s
    @pieces = @pieces.sort_by { |item| item[:id] }.reverse
    render 'index'
  end

  def new
    @piece = Piece.new
  end

  def create

    piece_params

    @piece = Piece.new( piece_params )

    authorize! :create, @piece

    @piece.user = current_user

    if @piece.save
       redirect_to @piece
    else
       render 'new'
    end
  end

  def show
    @piece = Piece.find(params[:id])
  end

  def edit
    @piece = Piece.find(params[:id])
    authorize! :update, @piece
  end

  def update
    @piece = Piece.find(params[:id])
    authorize! :update, @piece

    piece_params
    if @piece.update_attributes(piece_params)
       redirect_to @piece
    else
       render 'edit'
    end
  end

  def destroy
    @piece = Piece.find(params[:id])
    piece = @piece.destroy
    redirect_to pieces_path
  end

  def own
    @piece = Piece.find(params[:id])
  end


private

  def sort_colours_in_array(pieces)
    colours = pieces.map{ |i| i[:colour] }.uniq
    sorted_colourlist = []
    COLOURS.map { |col|   (sorted_colourlist << col) if colours.include? col }
    sorted_colourlist
  end

  def piece_params
    params.require( :piece ).permit( :name, :brand, :description, :image, :image_b, :size, :colour, :product_type, :price_cat, :image_cache, :image_b_cache, :available, colour: [])
  end
end
