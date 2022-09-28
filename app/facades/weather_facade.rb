class WeatherFacade
  def self.weather(lat, lon)
    weather_data = WeatherService.get_weather(lat, lon)
    current = current_weather(weather_data)
    daily = daily_weather(weather_data)[0..4]
    hourly = hourly_weather(weather_data)[0..7]
    Forecast.new(current, daily, hourly)
  end
  
  def self.weather_at_destination(lat, lon)
    hourly_weather(WeatherService.get_weather(lat, lon))
  end

  def self.current_weather(data)
    CurrentWeather.new(data[:current])
  end

  def self.daily_weather(data)
    data[:daily].map do |day|
      DailyWeather.new(day)
    end
  end

  def self.hourly_weather(data)
    data[:hourly].map do |hour|
      HourlyWeather.new(hour)
    end
  end

end