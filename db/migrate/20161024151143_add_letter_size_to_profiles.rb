class AddLetterSizeToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :letter_size, :string
  end
end
