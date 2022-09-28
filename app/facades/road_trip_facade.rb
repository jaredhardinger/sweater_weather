class RoadTripFacade
  def self.new_trip(origin, destination)
    directions_data = get_directions(origin, destination)
    if directions_data[:message]
      directions_data
    else
      forecast = WeatherFacade.weather_at_destination(directions_data[:lat], directions_data[:lng])
      travel_time_hrs = directions_data[:travel_time].to_i
      forecast_at_arrival = { conditions: forecast[travel_time_hrs].conditions, temperature: forecast[travel_time_hrs].temperature }
      RoadTrip.new( start_city: directions_data[:start_city],
                    end_city: directions_data[:end_city],
                    travel_time: directions_data[:travel_time],
                    weather_at_eta: forecast_at_arrival)
    end
  end

  private
  def self.get_directions(origin, destination)
    directions = LocationService.get_directions(origin, destination)
    if directions[:info][:statuscode] == 0
      lat = directions[:route][:locations].last[:displayLatLng][:lat]
      lng = directions[:route][:locations].last[:displayLatLng][:lng]
      start_city = directions[:route][:locations][0][:adminArea5] + ", " + directions[:route][:locations][0][:adminArea3]
      end_city = directions[:route][:locations][1][:adminArea5] + ", " + directions[:route][:locations][1][:adminArea3]
      trip_time = directions[:route][:formattedTime]
      { lat: lat, lng: lng, start_city: start_city, end_city: end_city, travel_time: trip_time }
    else
      { message: directions[:info][:messages][0] }
    end
  end
end


# {
#     "route": {
#         "routeError": {
#             "errorCode": 2,
#             "message": ""
#         }
#     },
#     "info": {
#         "statuscode": 402,
#         "copyright": {
#             "imageAltText": "© 2022 MapQuest, Inc.",
#             "imageUrl": "http://api.mqcdn.com/res/mqlogo.gif",
#             "text": "© 2022 MapQuest, Inc."
#         },
#         "messages": [
#             "We are unable to route with the given locations."
#         ]
#     }
# }