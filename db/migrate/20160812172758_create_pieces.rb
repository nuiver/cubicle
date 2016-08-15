class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.string :name
      t.string :brand
      t.text :description
      t.string :image
      t.string :image_b
      t.string :size
      t.string :colour
      t.string :type

      t.timestamps
    end
  end
end
