class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordInvalid, with: :return_errors
  
  def return_errors(exception)
    render json: {message: exception.message}, status: 400
  end
end
