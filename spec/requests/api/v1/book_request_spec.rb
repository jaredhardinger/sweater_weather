require 'rails_helper'

RSpec.describe "Forecast API Request" do
  before do
    weather_response = File.read('spec/fixtures/manistee_weather.json')
		stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['weather_api_key']}&exclude=minutely&lat=44.245812&lon&units=imperial").
      to_return(status: 200, body: weather_response)
		location_response = File.read('spec/fixtures/manistee_geocode.json')
		stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?location=manistee,mi&key=#{ENV['mapquest_api_key']}").
				to_return(status: 200, body: location_response)
    book_response = File.read('spec/fixtures/manistee_books.json')
    query = 'manistee'
		stub_request(:get, "http://openlibrary.org/search.json?limit=5&place=#{query}").
				to_return(status: 200, body: book_response)
  end
  describe 'Happy Path' do 
    it 'takes in a location and returns a forecast and books based on that location' do
      query = 'manistee,mi'
      get "/api/v1/book-search?location=manistee&quantity=5"
      expect(response).to have_http_status 200

      parsed = JSON.parse(response.body, symbolize_names: true)

    end
  end
end