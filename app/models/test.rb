class Test < ApplicationRecord
  has_many :questions
  has_many :test_results
  has_many :users, through: :test_results

  belongs_to :category
  belongs_to :author, class_name: "User"

  scope :easy, -> { where(level: 0..1) }
  scope :normal, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }
  scope :by_level, ->(level) { where(level: level) }
  scope :by_category, ->(name) { Test.joins(:category).where("categories.title LIKE ?", "%#{name}%") }

  def self.find_by_category(category_name)
    by_category(category_name)
      .order(id: :DESC)
      .pluck(:title)
  end
end
