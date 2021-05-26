class Api::V1::RevenueController < ApplicationController
  def merchants_revenue
    merchants = Merchant.revenue.limit(params[:quantity].to_i)
    render json: MerchantNameRevenueSerializer.new(merchants)
  end
end