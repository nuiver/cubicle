class ChangeSizeInPieces < ActiveRecord::Migration[5.0]
  def change
    change_column :pieces, :size, :string
  end
end
