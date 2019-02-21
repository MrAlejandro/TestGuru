class User < ApplicationRecord
  has_many :test_results
  has_many :tests, through: :test_results

  def find_test_by_level(level)
    Test
      .joins("JOIN test_results ON tests.id = test_results.test_id")
      .where("test_results.user_id = ? AND tests.level = ?", id, level)
  end
end
