class UsersController < ApplicationController
  before_filter :require_login, except: [:create]
  before_filter :require_admin_role, only: [:index]
  def index 
    render json: {  users: User.all() }
  end
  
  def create
    u = User.create! user_params
    render json: { message: "user created", user: u.to_json}
  end
  
  def update
    if @current_user
      @current_user.update user_params
      render json: { message: "user update"}
    else 
      render json: { message: "user not found"}, status: :badrequest
    end
  end
  
  def destroy
    if @current_user
      @current_user.destroy
      render json: { message: "user account deleted"}
    else 
      render json: { message: "user not found"}, status: :badrequest
    end
  end
  
  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :password, :password_confirmation, :email)
  end
end
