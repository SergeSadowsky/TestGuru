class TestAttempt < ApplicationRecord
  belongs_to :user
  belongs_to :test

  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_validation :before_validation_set_next_question, on: :update

  SUCCESS_SCORE = 85

  def completed?
    current_question.nil?
  end
  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end

    save!
  end

  def success?
    test_score >= SUCCESS_SCORE
  end

  def test_score
    correct_questions / test.questions.count.to_f * 100
  end

  private

  def correct_answer?(answer_ids)
    (correct_answers.ids.sort == (answer_ids || []).map(&:to_i).sort)
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def before_validation_set_next_question
    self.current_question = next_question
  end
end
