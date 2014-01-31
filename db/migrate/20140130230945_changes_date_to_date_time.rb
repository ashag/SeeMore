class ChangesDateToDateTime < ActiveRecord::Migration
  def change
    remove_column :posts, :date
    add_column :posts, :datetime, :datetime
  end
end
