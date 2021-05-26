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
    create_list(:merchant, 10)
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:id]).to eq(merchant.id.to_s)
  end

  it 'get all items for a given merchant ID' do
    merchant = create(:merchant)
    create_list(:item, 10, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].size).to eq(10)
    expect(json[:data].first[:attributes][:name]).to eq(Item.first.name)
    expect(json[:data].last[:attributes][:name]).to eq(Item.last.name)
  end

  context 'finding a merchant' do
    it 'happy path: it finds a merchant' do
      merchant = create(:merchant, name: 'ooga')
      get "/api/v1/merchants/find?name=oo"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(json[:data][:attributes][:name]).to eq('ooga')
    end
  end

  context 'merchant with the most items' do
    before {
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)

      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_2)
      @item_3 = create(:item, merchant: @merchant_3)

      @invoice_1 = create(:invoice, merchant: @merchant_1, customer: @customer_1)
      @invoice_2 = create(:invoice, merchant: @merchant_2, customer: @customer_2)
      @invoice_3 = create(:invoice, merchant: @merchant_3, customer: @customer_3)

      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, unit_price: 1)
      @invoice_item_1_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, unit_price: 1)
      @invoice_item_1_2 = create(:invoice_item, item: @item_1, invoice: @invoice_1, unit_price: 1)
      @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2, unit_price: 2)
      @invoice_item_2_1 = create(:invoice_item, item: @item_2, invoice: @invoice_2, unit_price: 2)
      @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_3, unit_price: 3)

      @tranaction_1 = create(:transaction, invoice: @invoice_1)
      @tranaction_2 = create(:transaction, invoice: @invoice_2)
      @tranaction_3 = create(:transaction, invoice: @invoice_3)
    }

    it 'happy path' do
      get '/api/v1/merchants/most_items?quantity=8'
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data].size).to eq(3)
      expect(merchant[:data].first[:attributes][:count]).to eq(3)
      expect(merchant[:data].last[:attributes][:count]).to eq(1)
    end
  end
end
