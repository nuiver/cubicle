class ChangeSizeToIntegerInProfile < ActiveRecord::Migration[5.0]

  def up
    execute 'ALTER TABLE profiles ALTER COLUMN size TYPE integer USING (size::integer)'
  end

  def down
    execute 'ALTER TABLE profiles ALTER COLUMN size TYPE text USING (size::text)'
  end

end
