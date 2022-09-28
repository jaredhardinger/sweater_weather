class Api::V1::UsersController < ApplicationController
  def create
    new_user = UsersFacade.register(user_params)
    if new_user.save
      render json: UsersSerializer.new(new_user), status: 201
    else
      render json: new_user.errors.full_messages, status: 403
    end
  end

  def login
    user = UsersFacade.find_user(user_params)
    if user
      render json: UsersSerializer.new(user), status: 200
    else
      render json: { message: "Incorrect email/password" }, status: 401 
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end