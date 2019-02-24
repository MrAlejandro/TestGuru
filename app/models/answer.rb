class Answer < ApplicationRecord
  validates :body, presence: true
  validate :validate_question_answers_number

  belongs_to :question, optional: true

  scope :correct, -> { where(correct: true) }

  private

  def validate_question_answers_number
    if question && question.num_of_answers >= 4
      errors.add(:answers, "Parent question already have 4 answers.")
    end
  end
end
