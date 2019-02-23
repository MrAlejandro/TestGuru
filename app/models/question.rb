class Question < ApplicationRecord
  validates :body, presence: true
  validate :validate_num_of_answers

  has_many :answers
  belongs_to :test, optional: true

  private

  def validate_num_of_answers
    errors.add(:answers, "Number of answers must be from 1 to 4.") unless answers.size.between?(1, 4)
  end
end
