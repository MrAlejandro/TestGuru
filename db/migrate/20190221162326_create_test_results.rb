class CreateTestResults < ActiveRecord::Migration[5.2]
  def change
    create_table :test_results do |t|
      t.belongs_to :user, index: true
      t.belongs_to :test, index: true
      t.decimal :score
      t.string :status, default: :in_progress

      t.timestamps
    end
  end
end
