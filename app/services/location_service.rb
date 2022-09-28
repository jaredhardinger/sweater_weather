class LocationService
  def self.get_coordinates(query)
    response = conn.get('/geocoding/v1/address?') do |req|
      req.params['location'] = query
      req.params['key'] = ENV['mapquest_api_key']
    end
    parse_json(response)
  end

  def self.get_directions(origin, destination)
    response = conn.get('/directions/v2/route?') do |req|
      req.params['from'] = origin
      req.params['to'] = destination
      req.params['key'] = ENV['mapquest_api_key']
    end
    parse_json(response)
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com')
  end
end