class AddSubTypeToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :sub_type, :string
  end
end
