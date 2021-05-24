require 'rails_helper'

describe 'Merchant API' do
  it 'get all merchants, a maximum of 20 at a time' do
    create_list(:merchant, 21)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].size).to eq(20)
  end

  it 'one merchant' do

  end

  it 'get all items for a given merchant ID' do

  end
end