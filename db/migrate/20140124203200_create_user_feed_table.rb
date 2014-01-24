class CreateUserFeedTable < ActiveRecord::Migration
  def change
    create_table :user_feeds do |t|
      t.string :user_id
      t.string :feed_id

      t.timestamps
    end
  end
end
