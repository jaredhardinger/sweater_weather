class UsersFacade
  def register(user)
    user[:email] = user[:email].downcase
    new_user = User.create(user)
  end
end