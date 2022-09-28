class UsersFacade
  def self.register(user)
    user[:email] = user[:email].downcase
    Users.create(user)
  end
end