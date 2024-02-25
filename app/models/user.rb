class User < ApplicationRecord
  has_many :test_attempts
  def tests_by_level(level)
    # Test.joins(:test_attempts).where('test_attempts.user_id = ?', id).where(level: level)
    Test.joins(:test_attempts).where(test_attempts: { user_id: id}, level: level)
  end
end
