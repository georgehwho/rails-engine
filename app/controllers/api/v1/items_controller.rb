class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  def index
    items = Item.paginate(params)
    render json: ItemSerializer.new(items)
  end

  def show
    render json: ItemSerializer.new(@item)
  end

  def create
    item = Item.create(item_params)
    render json: ItemSerializer.new(item), status: 201
  end

  def update
    if @item.update(item_params)
      render json: ItemSerializer.new(@item), status: 201
    else
      render json: { error: @item.errors.messages }, status: 404
    end
  end

  def destroy
    @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end