require 'rails_helper'

RSpec.describe 'Weather PORO' do
  context 'creates weather POROs' do
    before do
      response = File.read('spec/fixtures/manistee_weather.json')
      weather = JSON.parse(response, symbolize_names: true)
      @current = CurrentWeather.new(weather[:current])
      @daily = DailyWeather.new(weather[:daily][0])
      @hourly = HourlyWeather.new(weather[:hourly][0])
    end

    it 'creates a current weather PORO' do 
      expect(@current).to be_a(CurrentWeather)
      expect(@current.datetime).to be_a(String)
      expect(@current.sunrise).to be_a(String)
      expect(@current.sunset).to be_a(String)
      expect(@current.temperature).to be_a(Float)
      expect(@current.feels_like).to be_a(Float)
      expect(@current.humidity).to be_a(Integer)
      expect(@current.uvi).to be_a(Integer)
      expect(@current.visibility).to be_a(Integer)
      expect(@current.conditions).to be_a(String)
      expect(@current.icon).to be_a(String)
    end

    it 'creates a daily weather PORO' do
      expect(@daily).to be_a(DailyWeather)
      expect(@daily.date).to be_a(String)
      expect(@daily.sunrise).to be_a(String)
      expect(@daily.sunset).to be_a(String)
      expect(@daily.max_temp).to be_a(Float)
      expect(@daily.min_temp).to be_a(Float)
      expect(@daily.conditions).to be_a(String)
      expect(@daily.icon).to be_a(String)
    end

    it 'creates an hourly weather PORO' do
      expect(@hourly).to be_a(HourlyWeather)
      expect(@hourly.time).to be_a(String)
      expect(@hourly.temperature).to be_a(Float)
      expect(@hourly.conditions).to be_a(String)
      expect(@hourly.icon).to be_a(String)
    end

    it 'creates a combined current, daily, hourly weather PORO' do
      combined = Weather.new(@current, @daily, @hourly)
      expect(combined).to be_a(Weather)
      expect(combined.current_weather).to be_a(CurrentWeather)
      expect(combined.daily_weather).to be_a(DailyWeather)
      expect(combined.hourly_weather).to be_a(HourlyWeather)
    end
  end
end