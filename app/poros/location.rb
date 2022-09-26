class Location
  attr_reader :lat, :lon

  def initialize(coordinates)
    @lat = coordinates[:lat]
    @lon = coordinates[:lon]
  end
end