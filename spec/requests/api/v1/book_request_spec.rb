require 'rails_helper'

RSpec.describe "Forecast API Request" do
  before do
    weather_response = File.read('spec/fixtures/manistee_weather.json')
		stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['weather_api_key']}&exclude=minutely&lat=44.245812&lon&units=imperial").
      to_return(status: 200, body: weather_response)
		location_response = File.read('spec/fixtures/manistee_geocode.json')
		stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mapquest_api_key']}&location=manistee").
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

      data = parsed[:data]
      expect(data[:id]).to eq("null")
      expect(data[:type]).to eq("books")
      attributes = data[:attributes]
      expect(attributes[:destination]).to eq("manistee")
      expect(attributes[:total_books_found]).to eq(43)
      forecast = attributes[:forecast]
      expect(forecast[:summary]).to eq("overcast clouds")
      expect(forecast[:temperature]).to eq("57.47 F")
      books = attributes[:books]
      expect(books[0][:isbn]).to be_an(Array)
      expect(books[0][:title]).to be_a(String)
      expect(books[0][:publisher]).to be_an(Array)
    end
  end
end