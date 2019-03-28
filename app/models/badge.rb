class Badge < ApplicationRecord
  validates :name, presence: true
  validates :image_url, presence: true

  has_many :user_badges
  has_many :users, through: :user_badges
end
