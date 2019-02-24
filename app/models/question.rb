class Question < ApplicationRecord
  validates :body, presence: true

  has_many :answers
  belongs_to :test, optional: true

  def num_of_answers
    answers.count
  end
end
