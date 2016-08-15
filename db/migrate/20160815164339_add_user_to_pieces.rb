class AddUserToPieces < ActiveRecord::Migration[5.0]
  def change
    add_reference :pieces, :user, foreign_key: true
  end
end
