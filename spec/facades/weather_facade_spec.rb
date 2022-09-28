require 'rails_helper'

RSpec.describe 'Weather Facade' do 
  before do
		json_response = File.read('spec/fixtures/manistee_weather.json')
		stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['weather_api_key']}&exclude=minutely&lat=44.24&lon=-82.32&units=imperial").
				to_return(status: 200, body: json_response)
	end
  
  it 'returns the weather when given lat lng' do
		lat = "44.24"
		lon = "-82.32" 
    result = WeatherFacade.weather(lat, lon)

    expect(result).to be_a(Forecast)
  end

	it 'returns the hourly weather for 48 hours' do 
		lat = "44.24"
		lon = "-82.32"
		result = WeatherFacade.weather_at_destination(lat, lon)

		expect(result).to include(HourlyWeather)
		expect(result.count).to eq(48)
	end
end