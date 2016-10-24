class AddLingSizeToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :ling_size, :string
  end
end
