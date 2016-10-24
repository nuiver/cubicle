class ChangeSizeInProfiles < ActiveRecord::Migration[5.0]
  def change
    change_column :profiles, :size, :string
  end
end
