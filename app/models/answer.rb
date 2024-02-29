class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_max_answers_quantity, on: :create

  scope :correct, -> { where(correct: true) }

  private

  def validate_max_answers_quantity
    message = 'It cannot have more than four answers!'
    errors.add(:question, message) if question.answers.count >= 4
  end
end
