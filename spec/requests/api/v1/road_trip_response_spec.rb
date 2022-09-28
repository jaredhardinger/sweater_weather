require 'rails_helper'

RSpec.describe 'Road Trip API Response' do 
  before do
    user_attributes = { email: 'hi@example.com', password: 'passwerd', password_confirmation: 'passwerd' }
    @user = Users.create(user_attributes)

    sad_response = File.read('spec/fixtures/denver_glasgow_directions.json')
    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=denver,co&key=#{ENV['mapquest_api_key']}&to=glasgow,uk").
      to_return(status: 401, body: sad_response)

    happy_response = File.read('spec/fixtures/denver_pueblo_directions.json')
    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=denver,co&key=#{ENV['mapquest_api_key']}&to=pueblo,co").
      to_return(status: 200, body: happy_response)

    sad_weather_response = File.read('spec/fixtures/glasgow_weather.json')
    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['weather_api_key']}&exclude=minutely&lat=38.265427&lon=-104.610413&units=imperial").
      to_return(status: 200, body: sad_weather_response)
  end
  context 'CREATE' do
    describe 'happy :) path' do 
      it 'returns attributes and status code 200' do 
        headers = { 'CONTENT_TYPE': 'application/json' }
        params = {
            "origin": "denver,co",
            "destination": "pueblo,co",
            "api_key": "#{@user.api_key}"
          }
        post "/api/v1/road_trip", headers: headers, params: JSON.generate(params)
        data = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(data[:id]).to be(nil)
        expect(data[:type]).to eq("roadtrip")
        attributes = data[:attributes]
        expect(attributes).to be_a(Hash)
        expect(attributes[:start_city]).to eq("Denver, CO")
        expect(attributes[:end_city]).to eq("Pueblo, CO")
        expect(attributes[:travel_time]).to be_a(String)
        weather = attributes[:weather_at_eta]
        expect(weather[:conditions]).to be_a(String)
        expect(weather[:temperature]).to be_a(Float)
     
        expect(data).to_not have_key(:message)

        expect(response).to have_http_status(200)
      end
    end

    describe 'sad :( path' do
      it 'returns a 403 response code and error message if route cannot be given' do
        headers = { 'CONTENT_TYPE': 'application/json' }
        params = {
            "origin": "denver,co",
            "destination": "glasgow,uk",
            "api_key": "#{@user.api_key}"
          }
        post "/api/v1/road_trip", headers: headers, params: JSON.generate(params)
        error_msg = JSON.parse(response.body, symbolize_names: true)[:message]
        expect(error_msg).to eq("We are unable to route with the given locations.")
        expect(response).to have_http_status(403)
      end

      it 'returns a 401 response code if an incorrect API key is used' do
        headers = { 'CONTENT_TYPE': 'application/json' }
        params = {
            "origin": "denver,co",
            "destination": "glasgow,uk",
            "api_key": "this_isnt_real"
          }
        post "/api/v1/road_trip", headers: headers, params: JSON.generate(params)
        error_msg = JSON.parse(response.body, symbolize_names: true)[:message]
        expect(error_msg).to eq("Invalid API key")
        expect(response).to have_http_status(401)
      end
    end
  end
end