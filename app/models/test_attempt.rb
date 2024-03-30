class TestAttempt < ApplicationRecord
  belongs_to :user
  belongs_to :test

  belongs_to :current_question, class_name: 'Question', optional: true
  
  before_validation :before_validation_set_current_question, on: %i[create update]

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

  def current_question_index
    test.questions.count - remaining_questions.count
  end

  private

  def correct_answer?(answer_ids)
    (correct_answers.ids.sort == (answer_ids || []).map(&:to_i).sort)
  end

  def correct_answers
    current_question.answers.correct
  end

  def before_validation_set_current_question
    self.current_question = remaining_questions.first if test.present?
  end

  def remaining_questions
    current_question_id = current_question&.id || 0
    puts current_question_id
    test.questions.order(:id).where('id > ?', current_question_id)
  end
end
