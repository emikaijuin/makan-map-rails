class Listing < ApplicationRecord
  has_many :listing_users
  has_many :users, through: :listing_users

  before_create :create_coordinates

  scope :within_bounds, ->(bounds) {
                          where("latitude < ? AND latitude > ? AND longitude > ? AND longitude < ?",
                                bounds.dig("nw", "lat"),
                                bounds.dig("sw", "lat"),
                                bounds.dig("nw", "lng"),
                                bounds.dig("ne", "lng"))
                        }

  def create_coordinates
    begin
      response = HTTParty.get(
        'https://maps.googleapis.com/maps/api/geocode/json?' +
        "address=" + self.geocoding_address +
        "&key=" + Rails.application.credentials.google[:access_key]
      )

        self.lat = response.parsed_response["results"][0].dig("geometry", "location", "lat")
        self.long = response.parsed_response["results"][0].dig("geometry","location","lng")
    rescue
    end
  end

  def geocoding_address
    # Address to send as param to Geocoding API
    full_address = ""
    full_address += (self.address + " ") if self.address
    full_address += (self.secondary_address + " ") if self.secondary_address
    full_address += (self.city + " ") if self.city
    full_address += self.state if self.state

    full_address.gsub(" ", "+")
  end
end
