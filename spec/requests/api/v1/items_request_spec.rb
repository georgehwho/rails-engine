require 'rails_helper'

describe 'Item API' do
  let(:merchant) { create(:merchant) }

  it 'get all items, a maximum of 20 at a time' do
    create_list(:item, 21, merchant: merchant)

    get '/api/v1/items'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].size).to eq(20)
  end
  context 'finding an item' do
    let(:item) { create(:item, merchant: merchant)}

    it 'happy path: gets one item' do
      get "/api/v1/items/#{item.id}"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(json[:data][:id]).to eq(item.id.to_s)
    end

    it 'sad path: cannot find item' do
      get "/api/v1/items/0"

      expect(response).to have_http_status(404)
    end
  end

  context 'creating an item' do
    it 'happy path: creates one item' do
      item_params = { name: 'test item', description: 'lol', unit_price: 1, merchant_id: merchant.id }
      post "/api/v1/items", params: { item: item_params }
      item = Item.last

      expect(response).to be_successful
      expect(item.name).to eq(item_params[:name])
    end
  end

  it 'destroys one item' do
    item = create(:item, merchant: merchant)
    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.all.count).to eq(0)
  end

  context 'updating an item' do
    let(:item) { create(:item, merchant: merchant) }

    it 'happy path: updates one item' do
      item_params = { name: 'test item', description: 'lol', unit_price: 1, merchant_id: merchant.id }
      put "/api/v1/items/#{item.id}", params: { item: item_params }
      item = Item.last

      expect(response).to be_successful
      expect(item.name).to eq(item_params[:name])
    end

    it 'sad path: bad merchant' do
      item_params = { name: 'test item', description: 'lol', unit_price: 1, merchant_id: -1 }
      put "/api/v1/items/#{item.id}", params: { item: item_params }

      expect(response).to have_http_status(:not_found)
    end
  end
  context 'find a item\s merchant' do
    let(:item) { create(:item, merchant: merchant) }

    it 'gets one item\s merchant' do
      get "/api/v1/items/#{item.id}/merchant"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(json[:data][:id]).to eq(merchant.id.to_s)
    end
  end
end