class DealsController < ApplicationController

  def new
    @deal = Deal.new
  end

  def create

  end

  def index
    @deals = current_user.deals
    authorize! :read, @pieces
  end

end
