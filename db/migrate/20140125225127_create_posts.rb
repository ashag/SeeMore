class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :feed_id
      t.string :content
      t.date :date

      t.timestamps
    end
  end
end
