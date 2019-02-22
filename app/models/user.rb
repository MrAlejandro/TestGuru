class User < ApplicationRecord
  has_many :test_results
  has_many :tests, foreign_key: :author_id

  def find_test_by_level(level)
    Test
      .joins("LEFT JOIN test_results ON test_results.test_id = tests.id")
      .where("tests.level = ? AND test_results.user_id = ?", level, id)
      .distinct
  end
end
