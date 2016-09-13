class AddPieceToHearts < ActiveRecord::Migration[5.0]
  def change
    add_reference :hearts, :piece, foreign_key: true
  end
end
