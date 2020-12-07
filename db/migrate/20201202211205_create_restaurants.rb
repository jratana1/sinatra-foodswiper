class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :display_phone
      t.integer :rating
      t.string :url
      t.string :address
      t.string :yelp_id
      t.string :zip_code
      t.string :city
      t.string :state
      t.timestamps null: false
    end
  end
end
