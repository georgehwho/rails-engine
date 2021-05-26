require 'rails_helper'

describe 'Revenue API' do
  context 'merchant name revenue query' do
    it 'returns the top 2 merchants' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)

      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_3 = create(:customer)

      item_1 = create(:item, merchant: merchant_1)
      item_2 = create(:item, merchant: merchant_2)
      item_3 = create(:item, merchant: merchant_3)

      invoice_1 = create(:invoice, merchant: merchant_1, customer: customer_1)
      invoice_2 = create(:invoice, merchant: merchant_2, customer: customer_2)
      invoice_3 = create(:invoice, merchant: merchant_3, customer: customer_3)

      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, unit_price: 1)
      invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2, unit_price: 2)
      invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_3, unit_price: 3)

      get "/api/v1/revenue/merchants?quantity=2"
      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].size).to eq(2)
      expect(merchants[:data].first[:attributes][:revenue]).to eq(3.0)
      expect(merchants[:data].last[:attributes][:revenue]).to eq(2.0)
    end
  end

  context 'merchant revenue query' do
    it 'returns merchant 1' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)

      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_3 = create(:customer)

      item_1 = create(:item, merchant: merchant_1)
      item_2 = create(:item, merchant: merchant_2)
      item_3 = create(:item, merchant: merchant_3)

      invoice_1 = create(:invoice, merchant: merchant_1, customer: customer_1)
      invoice_2 = create(:invoice, merchant: merchant_2, customer: customer_2)
      invoice_3 = create(:invoice, merchant: merchant_3, customer: customer_3)

      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, unit_price: 1)
      invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2, unit_price: 2)
      invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_3, unit_price: 3)

      get "/api/v1/revenue/merchants/#{merchant_1.id}"
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data][:id]).to eq(merchant_1.id.to_s)
      expect(merchant[:data][:attributes][:revenue]).to eq(1.0)
    end
  end

  context 'items revenue query' do
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
      @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2, unit_price: 2)
      @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_3, unit_price: 3)
    }

    it 'returns by default 10 ' do
      get '/api/v1/revenue/items'

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data].size).to eq(3)
      expect(merchant[:data].first[:attributes][:revenue]).to eq(3.0)
      expect(merchant[:data].last[:attributes][:revenue]).to eq(1.0)
    end

    it 'returns amount of quantity specified' do
      get '/api/v1/revenue/items?quantity=2'

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data].size).to eq(2)
      expect(merchant[:data].first[:attributes][:revenue]).to eq(3.0)
      expect(merchant[:data].last[:attributes][:revenue]).to eq(2.0)
    end
  end
end