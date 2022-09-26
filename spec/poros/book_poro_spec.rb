require 'rails_helper'

RSpec.describe 'Book PORO' do
  it 'creates a PORO' do
    data = {
      isbn: "42",
      title: "forty-two",
      publisher: "marvin"
    }
    poro = Book.new(data)
    expect(poro).to be_a(Book)
    expect(poro.isbn).to be_a(String)
    expect(poro.publisher).to be_a(String)
    expect(poro.title).to be_a(String)
  end

  it 'creates a PORO when an isbn isnt given' do
    data = {
      title: "forty-two",
      publisher: "marvin"
    }
    poro = Book.new(data)
    expect(poro).to be_a(Book)
    expect(poro.isbn).to be_a(String) .or be(nil)
    expect(poro.publisher).to be_a(String)
    expect(poro.title).to be_a(String)
  end
end