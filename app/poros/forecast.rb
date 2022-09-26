class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather,
              :id

  def initialize(current_weather, daily_weather, hourly_weather)
    @id = nil
    @current_weather = current_weather
    @daily_weather = daily_weather
    @hourly_weather = hourly_weather
  end
end