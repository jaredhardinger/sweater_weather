class Api::V1::BookController < ApplicationController
  def index
    location = LocationFacade.coordinates(params[:location])
    forecast = WeatherFacade.weather(location.lat, location.lon)
    books = BookFacade.books(params[:location])
    render json: BookSerializer.new(params[:location], forecast, books), status: 200
  end
end