class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :uid
      t.string :type

      t.timestamps
    end
  end
end
