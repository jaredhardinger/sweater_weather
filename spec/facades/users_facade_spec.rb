require 'rails_helper' 

RSpec.describe 'Users Facade' do
  it 'downcases the email and creates a user' do 
    user_attributes = { email: 'JareD@example.com', password: 'passwerd', password_confirmation: 'passwerd'}
    user = UsersFacade.register(user_attributes)
    expect(user).to be_a(Users) 
    expect(user.email).to eq('jared@example.com')
  end

  it 'finds a user by email' do 
    user_attributes = { email: 'JareD@example.com', password: 'passwerd', password_confirmation: 'passwerd'}
    user = UsersFacade.register(user_attributes)
    found_user = UsersFacade.find_user(user_attributes)
    expect(found_user).to eq(user)
  end
end