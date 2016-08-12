class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :surname
      t.date :date_of_birth
      t.string :addr_street
      t.string :addr_number
      t.string :postcode
      t.string :addr_town
      t.string :fav_color
      t.string :phone
      t.string :gender

      t.timestamps
    end
  end
end
