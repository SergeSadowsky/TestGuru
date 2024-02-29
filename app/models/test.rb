class Test < ApplicationRecord
  has_many :test_attempts
  has_many :users, through: :test_attempts
  has_many :questions
  belongs_to :category
  belongs_to :author, class_name: 'User'

  validates :title, presence: true,
                    uniqueness: { scope: :level,
                                  message: 'Title and level must be unique',
                                  case_sensitive: false }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :level, ->(level) { where(level: level) }
  scope :beginner, -> { level(0..1) }
  scope :intermediate, -> { level(2..4) }
  scope :advanced, -> { level(5..Float::INFINITY) }

  scope :select_by_category, ->(category) { joins(:category).where(categories: { title: category }) }

  def self.by_category(category)
    # Category.find_by(title: category).tests.order(title: :desc).pluck(:title)
    select_by_category(category).pluck(:title)
  end

end
