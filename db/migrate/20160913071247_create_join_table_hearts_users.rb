class CreateJoinTableHeartsUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :hearts, :users do |t|
      # t.index [:heart_id, :user_id]
      # t.index [:user_id, :heart_id]
    end
  end
end
