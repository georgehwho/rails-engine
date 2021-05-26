class Merchant < ApplicationRecord
  include Concerns::Pagination

  validates :name, presence: true

  has_many :invoices, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoice_items

  def self.merchants_revenue
    joins(:transactions)
    .select("merchants.name as name,
             merchants.id as id,
             sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group(:name, :id)
    .order(revenue: :desc)
    .where("invoices.status = ? and transactions.result = ?", 'shipped', 'success')
  end

  def self.most_items
    joins(:transactions)
    .select("merchants.name as name,
             merchants.id as id,
             sum(invoice_items.quantity) as count")
    .where("transactions.result = ?", 'success')
    .group(:name, :id)
    .order('sum(invoice_items.quantity) desc')
  end

  def merchant_revenue
    transactions.select("items.merchant_id as merchant_id,
                         sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group('items.merchant_id')
    .order(revenue: :desc)
    .where("invoices.status = ? and transactions.result = ?", 'shipped', 'success')
    .first
  end
end
