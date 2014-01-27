class DropPreyTable < ActiveRecord::Migration
  def change
    drop_table :prey
  end
end
