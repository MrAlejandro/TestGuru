class Answer < ApplicationRecord
  validates :body, presence: true

  belongs_to :question, optional: true

  scope :correct, -> { where(correct: true) }
end
