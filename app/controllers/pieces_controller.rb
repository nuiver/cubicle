class PiecesController < ApplicationController
  def index
    @pieces = Piece.all
  end

  def new
    @piece = Piece.new
  end

end
