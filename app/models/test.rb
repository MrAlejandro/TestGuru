class Test < ApplicationRecord
  has_many :questions
  has_many :test_results
  has_many :users, through: :test_results

  belongs_to :category
  belongs_to :author

  def self.find_by_category(category_name)
    self
      .select("test.title")
      .joins("JOIN categories ON categories.id = tests.category_id")
      .where("categories.title LIKE ?", "%#{category_name}%")
      .order("tests.id DESC")
      .pluck(:title)
  end
end
