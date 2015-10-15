class TripsController < ApplicationController
  before_filter :require_login
  
  def index
    render json: {trips: Trip.all()}
  end
  
  def create
    trip = @current_user.trips.create!(trip_params)
  
    if trip
      render json: {message: "trip created", trip_id: trip.id }
    else
      render json: {}, status: :badrequest
    end
  end
  
  def update
    trip = Trip.find_by_id(params[:id])
  
    if trip
      trip.update(trip_params)
      render json: {message: "trip updated", trip: trip }
    else
      render json: {}, status: :badrequest
    end

  end
  

  
  def destroy
       trip = Trip.find_by_id(params[:id])

        if trip
          trip.destroy
          render json: {message: "trip removed"}
        else
          render json: {}, status: :badrequest
        end
  end
  
  def trip_params
    params.permit(:destination, :startDate, :endDate, :comment)
  end
end
