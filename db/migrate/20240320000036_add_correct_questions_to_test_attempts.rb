class AddCorrectQuestionsToTestAttempts < ActiveRecord::Migration[6.1]
  def change
    add_column :test_attempts, :correct_questions, :integer, default: 0
  end
end
