class TripsController < ApplicationController
  before_filter :require_login
  
  def index
    render json: Trip.all()
  end
  
  def require_login
    authenticate_or_request_with_http_token do |token,options|
      return true
    end
  end
end
