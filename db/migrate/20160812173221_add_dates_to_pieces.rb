class AddDatesToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :begin_date, :date
    add_column :pieces, :end_date, :date
  end
end
