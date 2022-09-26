class BookService
  def self.get_books(location)
    location = location.split(",").first if location.include? ","
    response = conn.get('/search.json?') do |req|
      req.params['limit'] = 5
      req.params['place'] = location
    end
    parse_json(response)
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  def self.conn
    Faraday.new(url: 'http://openlibrary.org')
  end
end