class Author < User
  has_many :tests

  def find_test_by_level(level)
    tests.where(level: level)
  end
end
