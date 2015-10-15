class AuthController < ApplicationController
  def create
    username = params["username"]
    password = params["password"]
    u = User.find_by_username(username)
    if username == Constants::ADMIN_USERNAME && password == ENV["TP_ADMIN_PASSWORD"]
      render json: {token: User.getAdminToken, role: 'admin' }
    elsif u && u.authenticate(password)
      render json: {token: u.getToken, role: 'user' }
    else
      render json: {message: "username password doesn't match."}, status: :unauthorized
    end
  end
  
  def destroy
     render json: {}
  end
end
