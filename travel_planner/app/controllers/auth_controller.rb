class AuthController < ApplicationController
  def create
    username = params["username"]
    password = params["password"]
    u = User.find_by_username(username)
    
    if u && u.authenticate(password)
      render json: {token: u.getToken }
    else
      render json: {message: "username password not match"}, status: :unauthorized
    end
  end
  
  def destroy
     render json: {}
  end
end
