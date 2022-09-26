class Location
  attr_reader :lat, :lng

  def initialize(coordinates)
    @lat = coordinates[:lat]
    @lng = coordinates[:lng]
  end
end