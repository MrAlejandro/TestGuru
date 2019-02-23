class User < ApplicationRecord
  has_many :test_results
  has_many :tests, -> {distinct}, through: :test_results
  has_many :created_tests, class_name: "Test", foreign_key: :author_id

  def find_test_by_level(level)
    tests.where(level: level)
  end
end
