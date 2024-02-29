class User < ApplicationRecord
  has_many :test_attempts
  has_many :tests, through: :test_attempts

  has_many :authored_tests, class_name: 'Test', foreign_key: "author_id"

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :tests_by_level, -> (level) { tests.where(level: level) }

  # def tests_by_level(level)
  #   tests.where(level: level)
  # end
end
