class CreateHearts < ActiveRecord::Migration[5.0]
  def change
    create_table :hearts do |t|

      t.timestamps
    end
  end
end
