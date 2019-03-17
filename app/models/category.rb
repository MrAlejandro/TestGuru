class Category < ApplicationRecord
  validates :title, presence: true

  has_many :tests
  has_many :badges

  default_scope { order(title: :ASC) }
end
