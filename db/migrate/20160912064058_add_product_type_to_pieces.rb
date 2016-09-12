class AddProductTypeToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :product_type, :string
  end
end
