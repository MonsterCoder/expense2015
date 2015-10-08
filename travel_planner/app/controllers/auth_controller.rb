class AuthController < ApplicationController
  def create
    username = params["username"]
    password = params["password"]
    u = User.find_by_username(username)
    
    if u && u.authenticate(password)
      token = JWT.encode({user_id: u.id}, Rails.application.secrets.secret_key_base)
      render json: {token: token }
    else
      render json: {message: "username password not match"}, status: :unauthorized
    end
  end
  
  def destroy
     render json: {}
  end
end
