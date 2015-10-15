class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordInvalid, with: :return_errors
  rescue_from ActionController::ParameterMissing, with: :return_errors
  
  def return_errors(exception)
    message = exception.message.sub('Validation failed: ','')
    
    render json: {message: message}, status: 400
  end
  
  def require_login
    authenticate_or_request_with_http_token do |token,options|
      if User.isAdmin(token)
        
        @current_user = User.find(params["user_id"].to_i)
 
      else
        @current_user = User.find_user_by_token token
      end
    end
  end
end
