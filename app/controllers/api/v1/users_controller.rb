class Api::V1::UsersController < ApplicationController
  def create
    binding.pry
    user = UserFacade.register(user_params)
    render json: UserSerializer.new(user), status: 201
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end