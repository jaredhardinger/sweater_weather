require 'rails_helper'

RSpec.describe "Mapquest API Service" do
	describe 'get coordinates' do 
		before do
			json_response = File.read('spec/fixtures/manistee_geocode.json')
			stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?location=manistee,mi&key=#{ENV['mapquest_api_key']}").
					to_return(status: 200, body: json_response)
		end
		
		it 'gets a response with the correct attributes' do
			query = 'manistee,mi' 
			response = LocationService.get_coordinates(query)
			expect(response).to be_a Hash
			expect(response).to have_key(:results)
			results = response[:results][0]
			expect(results).to have_key(:locations)
			locations = results[:locations][0]
			expect(locations).to have_key(:latLng)
			latLng = locations[:latLng]
			expect(latLng).to have_key(:lat)
			expect(latLng).to have_key(:lng)
		end 
	end

	describe 'get directions' do
		before do
			json_response = File.read('spec/fixtures/denver_pueblo_directions.json')
			stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=denver,co&key=#{ENV['mapquest_api_key']}&to=pueblo,co").
					to_return(status: 200, body: json_response)
		end

		it 'gets a response with the correct directions' do
			origin = 'denver,co'
			destination = 'pueblo,co' 
			response = LocationService.get_directions(origin, destination)
			expect(response).to be_a Hash
			expect(response).to have_key(:route)
			route = response[:route]
			expect(route[:formattedTime]).to be_a(String)
			locations = route[:locations]
			expect(locations[0][:adminArea3]).to be_a(String)
			expect(locations[0][:adminArea5]).to be_a(String)
			expect(route[:routeError][:message]).to be_empty
		end
	end
end