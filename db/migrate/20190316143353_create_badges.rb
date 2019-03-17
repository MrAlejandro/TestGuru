class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.string :image_url, null: false
      t.integer :quantity_condition, null: false
      t.integer :test_level, null: true
      t.boolean :first_try, null: false, default: false
      t.references :category, foreign_key: true, null: true

      t.timestamps
    end
  end
end
