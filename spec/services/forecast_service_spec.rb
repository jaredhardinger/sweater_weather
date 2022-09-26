require 'rails_helper'

RSpec.describe "OpenWeather API Service" do
	before do
		json_response = File.read('spec/fixtures/manistee_weather.json')
		stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?lat=44.24&lon=-82.32&appid=#{ENV['weather_api_key']}").
				to_return(status: 200, body: json_response)
	end
	
	it 'gets a response' do
		lat = "44.24"
		lon = "-82.32" 
		response = ForecastService(lat, lon)
		expect(response).to be_successful
	end 
end