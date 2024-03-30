class AddCurrentQuestionRefToTestAttempts < ActiveRecord::Migration[6.1]
  def change
    add_reference :test_attempts, :current_question, foreign_key: { to_table: :questions }
  end
end
