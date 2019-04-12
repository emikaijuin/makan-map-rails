class Listing < ApplicationRecord
  has_many :listing_users
  has_many :users, through: :listing_users

  after_create :create_coordinates

  scope :within_bounds, ->(bounds) {
                          where("latitude < ? AND latitude > ? AND longitude > ? AND longitude < ?",
                                bounds.dig("nw", "lat"),
                                bounds.dig("sw", "lat"),
                                bounds.dig("nw", "lng"),
                                bounds.dig("ne", "lng"))
                        }

  def create_coordinates
    response = HTTParty.get(
      'https://maps.googleapis.com/maps/api/geocode/json?' +
      "address=" + self.geocoding_address +
      "&key=" + Rails.application.credentials.google[:access_key]
    )

    self.lat = parsed_response.results.geometry.location.lat
    self.long = parsed_response.results.geometry.location.long

    self.save
  end

  def geocoding_address
    # Address to send as param to Geocoding API
    (self.address + " " + self.secondary_address + " " + self.city + " " + self.state).gsub(" ", "+")
  end
end
