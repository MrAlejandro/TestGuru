class AddIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :tests, :author_id
  end
end
