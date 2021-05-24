class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant
    if params[:per_page]
      if params[:per_page].to_i <= Merchant.count
        merchants = merchants.limit(params[:per_page].to_i)
      else
        merchants = merchants.limit(Merchant.count)
      end
    else
      merchants = merchants.limit(20)
    end
    merchants = merchants.offset((params[:page].to_i-1)*20) if params[:page].to_i > 1
    render json: MerchantSerializer.new(merchants)
  end

end