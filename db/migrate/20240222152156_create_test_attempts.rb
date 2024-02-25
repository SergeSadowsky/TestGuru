class CreateTestAttempts < ActiveRecord::Migration[6.1]
  def change
    create_table :test_attempts do |t|
      t.string :status
      t.string :result
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true

      t.timestamps
    end
  end
end
