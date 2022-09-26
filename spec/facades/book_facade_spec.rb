require 'rails_helper'

RSpec.describe 'Book Facade' do
	before do
		json_response = File.read('spec/fixtures/manistee_books.json')
    query = 'manistee'
		stub_request(:get, "http://openlibrary.org/search.json?limit=5&place=#{query}").
				to_return(status: 200, body: json_response)
	end

  it 'returns books when given a location' do
    location = 'manistee,mi'
    result = BookFacade.books(location)
    expect(result).to include(Book)
    expect(result.count).to eq(5)
  end
end