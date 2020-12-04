class User < ActiveRecord::Base
    has_secure_password
    has_many :photos
    has_many :likes, dependent: :destroy
    has_many :liked_restaurants, through: :likes, source: :restaurant

    extend Slugifiable::ClassMethods
    include Slugifiable::InstanceMethods
    validates :name, presence: true
    validates :name, uniqueness: true
    validates :email, presence: true
  end