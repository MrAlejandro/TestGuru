class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :gists
  has_many :feedbacks
  has_many :user_badges
  has_many :test_passages
  has_many :badges, through: :user_badges
  has_many :tests, through: :test_passages
  has_many :created_tests, class_name: "Test", foreign_key: :author_id

  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: true

  def find_test_by_level(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages
      .order(id: :desc)
      .find_by(test_id: test.id)
  end

  def admin?
    type == "Admin"
  end
end
