class Merchant < ApplicationRecord
  include Concerns::Pagination

  validates :name, presence: true

  has_many :invoices, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items

  def self.merchants_revenue
    joins(:invoice_items)
    .select("merchants.name as name, merchants.id as id, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group(:name, :id)
    .order(revenue: :desc)
  end

  def merchant_revenue
    invoice_items.select("items.merchant_id as merchant_id, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group('merchant_id')
    .order(revenue: :desc)
    .first
  end
end
