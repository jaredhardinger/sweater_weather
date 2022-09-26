require 'rails_helper'

RSpec.describe 'Location PORO' do
  it 'creates a PORO' do
    coordinates = {
      lat: 44.24,
      lng: -82.32
    }

    poro = Location.new(coordinates)
    expect(poro).to be_a(Location)
    expect(poro.lat).to eq(coordinates[:lat])
    expect(poro.lon).to eq(coordinates[:lng])
  end
end