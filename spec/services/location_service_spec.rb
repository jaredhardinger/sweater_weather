require 'rails_helper'

RSpec.describe "Mapquest API Service" do
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