require 'rails_helper'

RSpec.describe 'Users API Response' do 
  describe 'happy :) path' do 
    it 'returns email, api key, and status code 201' do 
      headers = { 'CONTENT_TYPE': 'application/json' }
      params = {
          "email": "jonn@example.com",
          "password": "passwerd",
          "password_confirmation": "passwerd"
        }
      post "/api/v1/users", headers: headers, params: JSON.generate(params)
      attributes = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
      expect(response).to have_http_status(201)
      expect(attributes[:email]).to eq(params[:email])
      expect(attributes[:api_key]).to be_a(String)
    end
  end

  describe 'sad :( path' do
    it 'returns a 403 response code and error message if user already exists' do
      headers = { 'CONTENT_TYPE': 'application/json' }
      params = {
          "email": "jon@example.com",
          "password": "passwerd",
          "password_confirmation": "passwerd"
        }
      post "/api/v1/users", headers: headers, params: JSON.generate(params)
      post "/api/v1/users", headers: headers, params: JSON.generate(params)
      error_msg = JSON.parse(response.body)
      expect(error_msg).to eq(["Email has already been taken"])
      expect(response).to have_http_status(403)
    end

    it 'returns a 403 response code and error message if passwords dont match' do
      headers = { 'CONTENT_TYPE': 'application/json' }
      params = {
          "email": "jon@example.com",
          "password": "passwerd",
          "password_confirmation": "password"
        }
      post "/api/v1/users", headers: headers, params: JSON.generate(params)
      error_msg = JSON.parse(response.body)
      expect(error_msg).to eq(["Password confirmation doesn't match Password"])
      expect(response).to have_http_status(403)
    end

    it 'returns a 403 response code and error message if email has already been taken' do
      headers = { 'CONTENT_TYPE': 'application/json' }
      params = {
          "email": "jon@example.com",
          "password": "passwerd",
          "password_confirmation": "passwerd"
        }
      post "/api/v1/users", headers: headers, params: JSON.generate(params)
      post "/api/v1/users", headers: headers, params: JSON.generate(params)
      error_msg = JSON.parse(response.body)
      expect(error_msg).to eq(["Email has already been taken"])
      expect(response).to have_http_status(403)
    end
  end
end