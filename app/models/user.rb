class User < ApplicationRecord
  has_secure_password

  validates :email,
    presence: true,
    format: {
      with: URI::MailTo::EMAIL_REGEXP,
      message: "Please provide a valid email address."
    }
  validates :password, presence: true, length: {minimum: 6, message: "Password is too short (min 6 characters)."}
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :listing_users
  has_many :listings, through: :listing_users
end
