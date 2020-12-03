class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :url
      t.integer :restaurant_id
      t.integer :user_id
      t.integer :leftswipes
      t.integer :rightswipes
      t.timestamps null: false
    end
  end
end