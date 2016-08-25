class AddPieceToDeals < ActiveRecord::Migration[5.0]
  def change
    add_reference :deals, :deal, foreign_key: true
  end
end
