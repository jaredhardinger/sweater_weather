require 'rails_helper'

RSpec.describe Users, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
  end

  describe 'instance methods' do
    it 'creates a new api_key' do 
      user_attributes = { email: 'hi@example.com', password: 'passwerd', password_confirmation: 'passwerd' }
      user = Users.create(user_attributes)
      expect(user.api_key).to_not be_empty
    end
  end

  describe 'class methods' do 
    it 'finds a user by api_key' do
      user_attributes = { email: 'hi@example.com', password: 'passwerd', password_confirmation: 'passwerd' }
      user = Users.create(user_attributes)
      found_user = Users.find_api_key(user.api_key)
      expect(user).to eq(found_user)
    end
  end
end