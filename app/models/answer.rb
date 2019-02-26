class Answer < ApplicationRecord
  validates :body, presence: true
  validate :validate_question_answers_number

  belongs_to :question

  scope :correct, -> { where(correct: true) }

  private

  def validate_question_answers_number
    errors.add(:answers, "question already has 4 answers.") if question.num_of_answers >= Question::MAX_NUMBER_OF_ANSWERS
  end
end
