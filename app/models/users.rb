class Users < ApplicationRecord
  before_validation :create_api_key
  validates :email, presence: true, uniqueness: true
  validates :api_key, uniqueness: true
  has_secure_password

  def self.find_api_key(key)
    Users.find_by(api_key: key)
  end

  private
  def create_api_key
    self.api_key = SecureRandom.urlsafe_base64
  end
end