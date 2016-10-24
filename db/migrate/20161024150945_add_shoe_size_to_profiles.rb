class AddShoeSizeToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :shoe_size, :string
  end
end
