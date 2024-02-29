class AddTitleLevelIndexToTests < ActiveRecord::Migration[6.1]
  def change
    # compound index for title,level pair uniqueness
    add_index :tests, [:title, :level], unique: true
  end
end
