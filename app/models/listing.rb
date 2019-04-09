class Listing < ApplicationRecord
  has_many :listing_users
  has_many :users, through: :listing_users
end
