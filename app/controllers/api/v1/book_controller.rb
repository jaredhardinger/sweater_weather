class Api::V1::BookController < ApplicationController
  def index
    location = LocationFacade.coordinates(params[:location])
    forecast = WeatherFacade.weather(location.lat, location.lon)
    books = BookFacade.books(params[:location])
    render json: BookSerializer.book_search(params[:location], forecast.current_weather, books), status: 200
    #i saw that there's an @instance_options method of passing params to serializer, but I just stuck with this
    #is there a specific way this should be done?
  end
end