class Api::V1::RevenueController < ApplicationController
  def merchants_revenue
    merchants = Merchant.merchants_revenue.limit(params[:quantity].to_i)
    render json: MerchantNameRevenueSerializer.new(merchants)
  end

  def merchant_revenue
    merchant = Merchant.find(params[:id]).merchant_revenue
    render json: MerchantRevenueSerializer.new(merchant)
  end

  def items_revenue
    if params[:quantity]
      items = Item.items_revenue.limit(params[:quantity].to_i)
    else
      items = Item.items_revenue.limit(10)
    end
    render json: ItemRevenueSerializer.new(items)
  end
end