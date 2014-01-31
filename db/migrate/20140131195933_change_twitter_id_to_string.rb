class ChangeTwitterIdToString < ActiveRecord::Migration
  def change
    change_column :posts, :twitter_id, :string
  end
end
