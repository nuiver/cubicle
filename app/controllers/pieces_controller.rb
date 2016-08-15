class PiecesController < ApplicationController
  def index
    @pieces = Piece.all
  end

  def new
    @piece = Piece.new
  end

  def create
    piece_params

    @piece = Piece.new( piece_params )
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

private

  def piece_params
    params.require( :piece ).permit( :name, :brand, :image, :image_b, :size, :colour, :price_cat )
  end
end
