require 'rails_helper'

RSpec.describe "OpenWeather API Service" do
	before do
		json_response = File.read('spec/fixtures/manistee_weather.json')
		stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?lat=44.24&lon=-82.32&exclude=minutely&units=imperial&appid=#{ENV['weather_api_key']}").
				to_return(status: 200, body: json_response)
	end
	
	it 'gets a response with the correct attributes' do
		lat = "44.24"
		lon = "-82.32" 
		response = ForecastService.get_forecast(lat, lon)
		expect(response).to be_a Hash
		expect(response).to have_key(:current)
		current = response[:current]
		expect(current).to have_key(:dt)
		expect(current).to have_key(:sunrise)
		expect(current).to have_key(:sunset)
		expect(current).to have_key(:temp)
		expect(current).to have_key(:feels_like)
		expect(current).to have_key(:humidity)
		expect(current).to have_key(:uvi)
		expect(current).to have_key(:visibility)
		current_weather = current[:weather][0]
		expect(current_weather).to have_key(:description)
		expect(current_weather).to have_key(:icon)
		daily = response[:daily][0]
		expect(daily).to have_key(:dt)
		expect(daily).to have_key(:temp)
		daily_weather = daily[:weather][0]
		expect(daily_weather).to have_key(:description)
		expect(daily_weather).to have_key(:icon)
		hourly = response[:hourly][0]
		expect(hourly).to have_key(:dt)
		expect(hourly).to have_key(:temp)
		hourly_weather = hourly[:weather][0]
		expect(hourly_weather).to have_key(:description)
		expect(hourly_weather).to have_key(:icon)

		expect(response).to_not have_key(:minutely)
	end 
end