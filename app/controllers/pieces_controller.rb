class PiecesController < ApplicationController

  load_and_authorize_resource

  def index
    if user_signed_in?
      @pieces = Piece.not_owned_by(current_user.id).order_by_new
    else
      @pieces = Piece.all.order_by_new
    end
    authorize! :read, @pieces
  end

  def owned
    @pieces = current_user.pieces
    authorize! :read, @pieces
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

private

  def piece_params
    params.require( :piece ).permit( :name, :brand, :image, :image_b, :size, :colour, :price_cat, :image_cache, :image_b_cache)
  end
end
