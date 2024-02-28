class Test < ApplicationRecord
  has_many :test_attempts
  has_many :users, through: :test_attempts
  has_many :questions
  belongs_to :category
  belongs_to :author, class_name: "User"
  def self.by_category(category)
    # Category.find_by(title: category).tests.order(title: :desc).pluck(:title)
    Test.joins(:category).where(categories: {title: category}).pluck(:title)
  end

end
