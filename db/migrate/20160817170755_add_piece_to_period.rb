class AddPieceToPeriod < ActiveRecord::Migration[5.0]
  def change
    add_reference :periods, :piece, foreign_key: true
  end
end
