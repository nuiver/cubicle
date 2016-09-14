class AddShippingToDeals < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :shipping, :string
    add_column :deals, :pay_method, :string
    add_column :deals, :del_address, :string
    add_column :deals, :del_number, :string
    add_column :deals, :del_postcode, :string
    add_column :deals, :del_town, :string
  end
end
