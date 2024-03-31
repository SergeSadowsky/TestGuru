require 'digest/sha1'

class User < ApplicationRecord

  # include Auth

  has_many :test_attempts
  has_many :tests, through: :test_attempts
  has_many :authored_tests, class_name: 'Test', foreign_key: :author_id

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_secure_password

  def tests_by_level(level)
    tests.level(level)
  end

  def test_attempt(test)
    test_attempts.order(id: :desc).find_by(test_id: test.id)
  end
end
