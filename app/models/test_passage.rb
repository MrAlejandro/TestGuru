class TestPassage < ApplicationRecord
  PASSAGE_PERCENT = 85.0

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_next_question, on: %i[create update]

  def accept!(answer_ids)
    if out_of_time?
      finish_test!
    else
      self.correct_questions += 1 if correct_answer?(answer_ids)
    end
    save!
  end

  def completed?
    current_question.nil?
  end

  def passed?
    score >= PASSAGE_PERCENT
  end

  def score
    (correct_questions / questions_number.to_f) * 100
  end

  def questions_number
    test.questions.count
  end

  def current_question_number
    test
      .questions
      .where("id <= ?", current_question.id)
      .count
  end

  def out_of_time?
    limited_in_time? && time_left.negative?
  end

  def limited_in_time?
    test.time_limit > 0
  end

  def time_left
    return test.time_limit unless created_at

    finish_before = created_at + test.time_limit.minute
    finish_before - Time.current
  end

  def to_s
    "#{score} %"
  end

  def finish_test!
    self.current_question = nil
  end

  private

  def correct_answer?(answer_ids)
    return false if answer_ids.nil? || answer_ids.empty?
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test
      .questions
      .where("id > ?", current_question || 0)
      .order(id: :ASC)
      .first
  end

  def before_validation_set_next_question
    self.current_question = next_question if !out_of_time? && test.present?
  end
end
