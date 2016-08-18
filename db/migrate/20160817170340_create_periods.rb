class CreatePeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :periods do |t|
      t.datetime :begin_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
