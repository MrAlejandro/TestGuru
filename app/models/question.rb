class Question < ApplicationRecord
  MAX_NUMBER_OF_ANSWERS = 4

  validates :body, presence: true

  has_many :gists
  has_many :answers
  belongs_to :test, optional: true

  def num_of_answers
    answers.count
  end
end
