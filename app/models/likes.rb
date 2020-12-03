class Like < ActiveRecord::Base
    belongs_to :restaurant
    belongs_to :user
    validates :user_id, uniqueness: {scope: :restaurant_id}
end