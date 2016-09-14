class ChangeAddressInDeals < ActiveRecord::Migration[5.0]
  def change
    rename_column :deals, :del_address, :del_street
    add_column :deals, :del_country, :string
  end
end
