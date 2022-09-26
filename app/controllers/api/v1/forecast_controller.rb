class Api::V1::ForecastController < ApplicationController
  def index
    location = LocationFacade.coordinates(params[:location])
    forecast = WeatherFacade.weather(location.lat, location.lon)
    render json: ForecastSerializer.new(forecast), status: 200
  end
end