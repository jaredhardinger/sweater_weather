class UsersFacade
  def self.register(user)
    user[:email] = user[:email].downcase
    Users.create(user)
  end

  def self.find_user(user_params)
    user = Users.find_by(email: user_params[:email])
    user.authenticate(user_params[:password]) if user
  end
end