class CreateDeals < ActiveRecord::Migration[5.0]
  def change
    create_table :deals do |t|
      t.date :begin_res
      t.date :end_res
      t.boolean :complete

      t.timestamps
    end
  end
end
