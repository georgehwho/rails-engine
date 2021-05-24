class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.paginate(params)
    render json: MerchantSerializer.new(merchants)
  end
end