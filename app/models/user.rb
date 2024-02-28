class User < ApplicationRecord
  has_many :test_attempts
  has_many :tests, foreign_key: "author_id"
  def tests_by_level(level)
    # Test.joins(:test_attempts).where('test_attempts.user_id = ?', id).where(level: level)
    Test.joins(:test_attempts).where(test_attempts: { user_id: id}, level: level)
  end
end
