class DropTableTestResults < ActiveRecord::Migration[5.2]
  def up
    drop_table :test_results, if_exists: true
  end

  def down
  end
end
