class AddProviderIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :twitter_id, :integer
  end
end
