class Api::V1::RevenueController < ApplicationController
  def merchants_revenue
    return render_search_error if params[:quantity].nil? || params[:quantity].to_i == 0
    merchants = Merchant.merchants_revenue.limit(params[:quantity].to_i)
    render json: MerchantNameRevenueSerializer.new(merchants)
  end

  def merchant_revenue
    merchant = Merchant.find(params[:id]).merchant_revenue
    render json: MerchantRevenueSerializer.new(merchant)
  end

  def items_revenue
    if params[:quantity].nil?
      items = Item.items_revenue.limit(10)
      render json: ItemRevenueSerializer.new(items)
    elsif params[:quantity] == '' || params[:quantity].to_i <= 0
      return render_search_error
    else
      items = Item.items_revenue.limit(params[:quantity].to_i)
      render json: ItemRevenueSerializer.new(items)
    end
  end
end