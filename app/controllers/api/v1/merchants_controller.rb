class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.paginate(params)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
  end

  def find
    merchants = Merchant.search(params[:name])
    return render_search_error if merchants.empty?
    render json: MerchantSerializer.new(merchants.first)
  end
end