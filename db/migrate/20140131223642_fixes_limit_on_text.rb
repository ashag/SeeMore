class FixesLimitOnText < ActiveRecord::Migration
  def change
    change_column :posts, :content, :text, limit: 100.megabytes
  end
end
