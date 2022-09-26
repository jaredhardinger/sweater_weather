class LocationFacade
  def self.coordinates(query)
    coords = LocationService.get_coordinates(query)
    Location.new(coords[:results][0][:locations][0][:latLng])
  end
end