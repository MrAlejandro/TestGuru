class Test < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :time_limit, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :questions
  has_many :test_passages
  has_many :users, through: :test_passages

  belongs_to :category
  belongs_to :author, class_name: "User", optional: true # TODO: remove optional when possible

  scope :easy, -> { where(level: 0..1) }
  scope :normal, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }
  scope :by_category, ->(name) { joins(:category).where("categories.title LIKE ?", "%#{name}%") }

  def self.find_title_by_category(category_name)
    by_category(category_name)
      .order(id: :DESC)
      .pluck(:title)
  end
end
