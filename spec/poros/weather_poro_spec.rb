require 'rails_helper'

RSpec.describe 'Weather PORO' do
  context 'creates weather POROs' do
    before do
      response = File.read('spec/fixtures/manistee_weather.json')
      weather = JSON.parse(response, symbolize_names: true)
      @current_weather = weather[:current] 
      @daily_weather = weather[:daily][0]
      @hourly_weather = weather[:hourly][0]
    end

    it 'creates a current weather PORO' do 
      poro = CurrentWeather.new(@current_weather)
      expect(poro).to be_a(CurrentWeather)
      expect(poro.datetime).to be_a(String)
      expect(poro.sunrise).to be_a(String)
      expect(poro.sunset).to be_a(String)
      expect(poro.temperature).to be_a(Float)
      expect(poro.feels_like).to be_a(Float)
      expect(poro.humidity).to be_a(Integer)
      expect(poro.uvi).to be_a(Integer)
      expect(poro.visibility).to be_a(Integer)
      expect(poro.conditions).to be_a(String)
      expect(poro.icon).to be_a(String)
    end

    it 'creates a daily weather PORO' do
      poro = DailyWeather.new(@daily_weather)
      expect(poro).to be_a(DailyWeather)
      expect(poro.date).to be_a(String)
      expect(poro.sunrise).to be_a(String)
      expect(poro.sunset).to be_a(String)
      expect(poro.max_temp).to be_a(Float)
      expect(poro.min_temp).to be_a(Float)
      expect(poro.conditions).to be_a(String)
      expect(poro.icon).to be_a(String)
    end

    it 'creates an hourly weather PORO' do
      poro = HourlyWeather.new(@hourly_weather)
      expect(poro).to be_a(HourlyWeather)
      expect(poro.time).to be_a(String)
      expect(poro.temperature).to be_a(Float)
      expect(poro.conditions).to be_a(String)
      expect(poro.icon).to be_a(String)
    end
  end
end