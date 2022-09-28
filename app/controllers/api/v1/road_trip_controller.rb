class Api::V1::RoadTripController < ApplicationController
  def create
    if Users.find_api_key(trip_params[:api_key])
      new_trip = RoadTripFacade.new_trip(trip_params[:origin], trip_params[:destination])
      if new_trip.is_a? RoadTrip
        render json: RoadTripSerializer.new(new_trip), status: 200
      else
        render json: { message: new_trip[:message] }, status: 403
      end
    else
      render json: { message: "Invalid API key" }, status: 401 
    end
  end
  private
  def trip_params
    params.require(:road_trip).permit(:origin, :destination, :api_key)
  end
end