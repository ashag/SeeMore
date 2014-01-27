class AddFeedUidToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :feed_uid, :string
    change_column :posts, :content, :text
  end
end
