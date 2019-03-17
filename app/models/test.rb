class Test < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :questions
  has_many :test_passages
  has_many :users, through: :test_passages

  belongs_to :category
  belongs_to :author, class_name: "User"

  scope :easy, -> { where(level: 0..1) }
  scope :normal, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }
  scope :by_category, ->(category_id) { where(category_id: category_id) }
  scope :by_category_name, ->(name) { joins(:category).where("categories.title LIKE ?", "%#{name}%") }
  scope :exclude, ->(test_ids) { where("id NOT IN (?)", test_ids.is_a?(Array) ? test_ids : [test_ids]) }

  def self.find_title_by_category(category_name)
    by_category_name(category_name)
      .order(id: :DESC)
      .pluck(:title)
  end
end
