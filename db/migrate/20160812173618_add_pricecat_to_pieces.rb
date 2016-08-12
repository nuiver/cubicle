class AddPricecatToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :price_cat, :integer
  end
end
