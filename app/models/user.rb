class User < ApplicationRecord
  has_many :test_results
  has_many :tests, through: :test_results

  def find_test_by_level(level)
    test_ids = self.test_results.pluck(:test_id).uniq
    Test.where(level: level).where(id: test_ids)
  end
end
