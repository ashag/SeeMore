class FixingLimitInPostContent < ActiveRecord::Migration
  def change
    change_column :posts, :content, :text, limit: 4294967296
  end
end
