class WeatherService
  def self.get_weather(lat, lon)
    response = conn.get('/data/2.5/onecall?') do |req|
      req.params['lat'] = lat
      req.params['lon'] = lon
      req.params['exclude'] = 'minutely'
      req.params['units'] = 'imperial'
      req.params['appid'] = ENV['weather_api_key']
    end
    parse_json(response)
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  def self.conn
    Faraday.new(url: 'https://api.openweathermap.org')
  end
end