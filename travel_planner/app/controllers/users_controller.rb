class UsersController < ApplicationController
  def create
    u = User.create! user_params
    render json: { message: "user created", user: u.to_json}
  end
  
  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :password, :password_confirmation, :email)
  end
end
