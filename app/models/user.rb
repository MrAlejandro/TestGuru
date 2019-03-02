class User < ApplicationRecord
  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :created_tests, class_name: "Test", foreign_key: :author_id

  has_secure_password

  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: true
  validates :name, presence: true


  def find_test_by_level(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages
      .order(id: :desc)
      .find_by(test_id: test.id)
  end
end
