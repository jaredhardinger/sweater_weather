require 'rails_helper'

RSpec.describe 'Location Facade' do
  before do
		json_response = File.read('spec/fixtures/manistee_geocode.json')
		stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?location=manistee,mi&key=#{ENV['mapquest_api_key']}").
				to_return(status: 200, body: json_response)
	end
  
  it 'returns the lat and lng when given a location' do
    query = 'manistee,mi'
    result = LocationFacade.coordinates(query)

    expect(result).to be_a(Location)
  end
end