require 'rails_helper'

RSpec.describe 'Book (OpenLibrary) API Service' do 
	before do
		json_response = File.read('spec/fixtures/manistee_books.json')
    query = 'manistee'
		stub_request(:get, "http://openlibrary.org/search.json?limit=5&place=#{query}").
				to_return(status: 200, body: json_response)
	end
	
	it 'gets a response with the correct attributes' do
    location = 'manistee,mi'
		response = BookService.get_books(location)
		expect(response).to be_a Hash

	end 
end