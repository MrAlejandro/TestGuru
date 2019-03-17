class Badge < ApplicationRecord
  enum quantity_condition: [ :all_tests, :any_test ]

  validates :name, presence: true
  validates :image_url, presence: true
  validates :quantity_condition, inclusion: { in: quantity_conditions.keys }

  validate :only_one_condition_should_be_selected

  has_many :user_badges
  has_many :users, through: :user_badges
  
  belongs_to :category, optional: true

  def quantity_conditions
    self.class.quantity_conditions.keys
  end

  protected

  def only_one_condition_should_be_selected
    one_condition_selected = [first_try, category_id, test_level]
                                 .select{ |item| item != false && !item.nil? }
                                 .count == 1

    unless one_condition_selected
      errors.add(:conditions, I18n.t("activerecord.errors.messages.only_one_condition"))
    end
  end
end
