class AddScoreToTestPassages < ActiveRecord::Migration[5.2]
  def change
    add_column :test_passages, :score, :float
  end
end
