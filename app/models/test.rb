class Test < ApplicationRecord
  def self.find_by_category(category_name)
    Test
      .select("test.title")
      .joins("JOIN categories ON categories.id = tests.category_id")
      .where("categories.title LIKE ?", "%#{category_name}%")
      .order("tests.id DESC")
      .pluck(:title)
  end
end
