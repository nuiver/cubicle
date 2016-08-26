class AddPieceToDeals < ActiveRecord::Migration[5.0]
  def change
    add_reference :deals, :piece, foreign_key: true
  end
end
