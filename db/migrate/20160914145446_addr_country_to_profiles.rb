class AddrCountryToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :del_country, :string
  end
end
