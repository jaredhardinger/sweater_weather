class Api::V1::UsersController < ApplicationController
  def create
    binding.pry
    new_user = UsersFacade.register(user_params)
    new_user.errors.full_messages
    render json: UsersSerializer.new(user), status: 201
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end