class DealsController < ApplicationController

  def new
    @deal = Deal.new
    @piece = Piece.find(params[:piece_id])
  end

  def create
    @deal = Deal.new(deal_params)
    @deal.user = current_user
    @deal.piece_id = params[:piece_id]
      respond_to do |format|
          if @deal.save
            format.html { render deal_path(@deal.id), notice: 'The deal was successfully proposed to the owner of the piece.' }
            format.json { render :show, status: :created, location: @deal }
            format.js
          else
            format.html { render new_deal_path(deal_params[:id]) }
            format.json { render json: @deal.errors, status: :unprocessable_entity }
          end
        end
  end

  def show
    @deal = Deal.find_by id: params[:id]
    # @piece = Piece.find_by(id: @deal.piece_id)
  end

  def index
    @deals = current_user.deals
    authorize! :read, @pieces
  end

  private

  def deal_params
      params.require(:deal).permit(:begin_res, :end_res, :piece_id, :piece, del_str)
  end

end
