class TripsController < ApplicationController
  before_filter :require_login
  
  def index
    render json: {trips: Trip.all()}
  end
  
  def create
    user = @current_user
  
    if user
      trip = user.trips.create!(trip_params)
      render json: {message: "trip created", trip: trip }
    else
      render json: {}, status: :badrequest
    end
  end
  
  def require_login
    authenticate_or_request_with_http_token do |token,options|
      @current_user = User.find_user_by_token token
    end
  end
  
  def trip_params
    params.require(:data).permit(:destination, :startDate, :endDate, :comment)
  end
end
