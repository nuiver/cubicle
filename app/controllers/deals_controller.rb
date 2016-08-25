class DealsController < ApplicationController

  def new
    @deal = Deal.new
    @piece = Piece.find(params[:piece_id])
  end

  def create
    @deal = Deal.new(deal_params)

      respond_to do |format|
          if @deal.save
            format.html { redirect_to deal_path(@deal.id), notice: 'The deal was successfully proposed to the owner of the piece.' }
            format.json { render :show, status: :created, location: @deal }
          else
            format.html { render new_deal_path(deal_params[:id]) }
            format.json { render json: @deal.errors, status: :unprocessable_entity }
          end
        end
  end

  def show
  end

  def index
    @deals = current_user.deals
    authorize! :read, @pieces
  end

  private

  def deal_params
      params.require(:deal).permit(:begin_res, :end_res)
  end

end
