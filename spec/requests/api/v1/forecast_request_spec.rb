require 'rails_helper'

RSpec.describe "Forecast API Request" do
  before do
    weather_response = File.read('spec/fixtures/manistee_weather.json')
		stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['weather_api_key']}&exclude=minutely&lat=44.245812&lon=-86.319545&units=imperial").
      to_return(status: 200, body: weather_response)
		location_response = File.read('spec/fixtures/manistee_geocode.json')
		stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?location=manistee,mi&key=#{ENV['mapquest_api_key']}").
				to_return(status: 200, body: location_response)
  end
  describe 'Happy Path' do 
    it 'takes in a location and returns a forecast' do
      query = 'manistee,mi'
      get "/api/v1/forecast?location=#{query}"
      expect(response).to have_http_status 200

      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:id]).to eq(nil)
      expect(parsed[:data][:type]).to eq("forecast")
      expect(parsed[:data][:attributes].count).to eq(3)
      expect(parsed[:data][:attributes][:current_weather].count).to eq(10)
      expect(parsed[:data][:attributes][:current_weather][:datetime]).to be_a(String)
      expect(parsed[:data][:attributes][:current_weather][:sunrise]).to be_a(String)
      expect(parsed[:data][:attributes][:current_weather][:sunset]).to be_a(String)
      expect(parsed[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
      expect(parsed[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
      expect(parsed[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)
      expect(parsed[:data][:attributes][:current_weather][:uvi]).to be_a(Integer)
      expect(parsed[:data][:attributes][:current_weather][:visibility]).to be_a(Integer)
      expect(parsed[:data][:attributes][:current_weather][:conditions]).to be_a(String)
      expect(parsed[:data][:attributes][:current_weather][:icon]).to be_a(String)
      expect(parsed[:data][:attributes][:daily_weather].count).to eq(5)
      expect(parsed[:data][:attributes][:daily_weather][0].count).to eq(7)
      expect(parsed[:data][:attributes][:daily_weather][0][:date]).to be_a(String)
      expect(parsed[:data][:attributes][:daily_weather][0][:sunrise]).to be_a(String)
      expect(parsed[:data][:attributes][:daily_weather][0][:sunset]).to be_a(String)
      expect(parsed[:data][:attributes][:daily_weather][0][:max_temp]).to be_a(Float)
      expect(parsed[:data][:attributes][:daily_weather][0][:min_temp]).to be_a(Float)
      expect(parsed[:data][:attributes][:daily_weather][0][:conditions]).to be_a(String)
      expect(parsed[:data][:attributes][:daily_weather][0][:icon]).to be_a(String)
      expect(parsed[:data][:attributes][:hourly_weather].count).to eq(8)
      expect(parsed[:data][:attributes][:hourly_weather][0].count).to eq(4)
      expect(parsed[:data][:attributes][:hourly_weather][0][:time]).to be_a(String)
      expect(parsed[:data][:attributes][:hourly_weather][0][:temperature]).to be_a(Float)
      expect(parsed[:data][:attributes][:hourly_weather][0][:conditions]).to be_a(String)
      expect(parsed[:data][:attributes][:hourly_weather][0][:icon]).to be_a(String)
    end
  end
end
"https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['weather_api_key']}&exclude=minutely&lat=44.245812&lon=-86.319545&units=imperial"