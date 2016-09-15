class AddProposalToDeals < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :proposal, :boolean, default: false
  end
end
