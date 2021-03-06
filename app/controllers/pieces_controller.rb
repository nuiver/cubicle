class PiecesController < ApplicationController

  helper_method :sort_colours_in_array

  # load_and_authorize_resource

  def index

    if user_signed_in?
      @pieces = Piece.where("end_date >= '#{Time.zone.now.beginning_of_day}'").not_owned_by(current_user.id).order_by_new
    else
      @pieces = Piece.all.where("end_date >= '#{Time.zone.now.beginning_of_day}'").order_by_new
    end
    if params[:search]
      @pieces = @pieces.search(params[:search])
    end
    @searchparams = params[:search]

    # @pieces = @pieces.where("end_date >= #{Time.zone.now.beginning_of_day}")
    @colours_in_unfiltered_pieces = @pieces.sort_colours_in_collection(@pieces)
    @sizes_in_unfiltered_pieces = @pieces.map{ |i| i[:size] }.uniq.sort { |a,b| a.to_i <=> b.to_i }
    @product_types_in_unfiltered_pieces = @pieces.sort_types_in_collection(@pieces)

    @pieces = @pieces.typesearch(params[:type]) if params[:type].present?
    @pieces = @pieces.coloursearch(params[:colour]) if params[:colour].present?
    @pieces = @pieces.sizesearch(params[:size]) if params[:size].present?
    @pieces = @pieces.are_available_now? if params[:available].present? && params[:available] == true.to_s
    @pieces = Piece.where(id: @pieces.map(&:id))
    # @pieces = @pieces.sort_by {|i| i[:updated_at] }.reverse
    @pieces = @pieces.paginate(:page => params[:page], :per_page => 10)
    authorize! :read, @pieces
  end

  def owned
    @pieces = current_user.pieces.where("end_date >= '#{Time.zone.now.beginning_of_day}'").order_by_new
    @colours_in_unfiltered_pieces = @pieces.sort_colours_in_collection(@pieces)
    @sizes_in_unfiltered_pieces = @pieces.map{ |i| i[:size] }.uniq.sort

    product_types = @pieces.map{ |i| i[:product_type] }.uniq
    sorted_typelist = []
    Piece::TYPES.map { |typ|   (sorted_typelist << typ) if product_types.include? typ }
    @product_types_in_unfiltered_pieces = sorted_typelist

    @pieces = @pieces.typesearch(params[:type]) if params[:type].present?
    @pieces = @pieces.coloursearch(params[:colour]) if params[:colour].present?
    @pieces = @pieces.sizesearch(params[:size]) if params[:size].present?
    @pieces = @pieces.are_available_now? if params[:available].present? && params[:available] == true.to_s
    @pieces = @pieces.paginate(:page => params[:page], :per_page => 10)

    authorize! :read, @pieces
    render 'index'
  end

  def hearted
    @pieces = Piece.where("end_date >= '#{Time.zone.now.beginning_of_day}'")

    @pieces_before = @pieces.select{|i| i.heart.users.ids.include? current_user.id }

    @pieces = @pieces.typesearch(params[:type]) if params[:type].present?
    @pieces = @pieces.coloursearch(params[:colour]) if params[:colour].present?
    @pieces = @pieces.sizesearch(params[:size]) if params[:size].present?
    @pieces = @pieces.are_available_now? if params[:available].present? && params[:available] == true.to_s
    @pieces = @pieces.select{|i| i.heart.users.ids.include? current_user.id }
    @pieces = Piece.where(id: @pieces.map(&:id)).order_by_new
    @pieces = @pieces.paginate(:page => params[:page], :per_page => 10)

    product_types = @pieces_before.map{ |i| i[:product_type] }.uniq
    sorted_typelist = []
    Piece::TYPES.map { |typ|   (sorted_typelist << typ) if product_types.include? typ }
    @product_types_in_unfiltered_pieces = sorted_typelist

    colours = @pieces_before.map{ |i| i[:colour] }.uniq
    sorted_colourlist = []
    Piece::COLOURS.map { |col|   (sorted_colourlist << col) if colours.include? col }
    @colours_in_unfiltered_pieces = sorted_colourlist

    @sizes_in_unfiltered_pieces = @pieces_before.map{ |i| i[:size] }.uniq.sort


    authorize! :read, @pieces
    render 'index'
  end

  def type
    authorize! :read, @pieces

    @pieces = Piece.where(product_type: params[:product_type]).order_by_new

    colours = @pieces.map{ |i| i[:colour] }.uniq
    sorted_colourlist = []
    Piece::COLOURS.map { |col|   (sorted_colourlist << col) if colours.include? col }
    @colours_in_unfiltered_pieces = sorted_colourlist
    @sizes_in_unfiltered_pieces = @pieces.map{ |i| i[:size] }.uniq.sort

    @pieces = @pieces.where("end_date >= '#{Time.zone.now.beginning_of_day}'")

    @pieces = @pieces.coloursearch(params[:colour]) if params[:colour].present?
    @pieces = @pieces.sizesearch(params[:size]) if params[:size].present?
    @pieces = @pieces.are_available_now? if params[:available].present? && params[:available] == true.to_s
    @pieces = @pieces.paginate(:page => params[:page], :per_page => 10)

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
    heart = Heart.where(piece_id: @piece.id)
    heart.destroy_all
    piece = @piece.destroy
    redirect_to pieces_path
  end

  def own
    @piece = Piece.find(params[:id])
  end


  def get_subtype
    type = params[:productType]
    subtypes = Object.const_get( "Piece::" + "SUB_" + type.upcase )
    respond_to do |format|
       format.json{ render json: { "subtypes": subtypes } }
    end
  end

  def get_sizelist
    subtype = params[:subtype]
    sizes = Object.const_get( "Piece::" + subtype.upcase + "_SIZES")
    puts sizes.class
    respond_to do |format|
       format.json{ render json:  { "sizes": sizes } }
    end
  end

private

  def sort_colours_in_array(pieces)
    colours = pieces.map{ |i| i[:colour] }.uniq
    sorted_colourlist = []
    Piece::COLOURS.map { |col|   (sorted_colourlist << col) if colours.include? col }
    sorted_colourlist
  end

  def piece_params
    params.require( :piece ).permit( :name, :brand, :description, :image, :image_b, :size, :ling_size, :shoe_size, :letter_size, :colour, :product_type, :sub_type, :price_cat, :image_cache, :image_b_cache, :available, :begin_date, :end_date, :search,  colour: [])
  end
end
