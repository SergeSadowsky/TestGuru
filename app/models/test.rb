class Test < ApplicationRecord
  has_many :test_attempts
  belongs_to :category
  def self.by_category(category)
    Category.find_by(title: category).tests.order(title: :desc).pluck(:title)
  end

end
