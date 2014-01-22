class CreatePrey < ActiveRecord::Migration
  def change
    create_table :prey do |t|
      t.string :uid
      t.string :provider

      t.timestamps
    end
  end
end
