class AddAcceptedToDeals < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :accepted, :boolean, default: false
  end
end
