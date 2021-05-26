class Item < ApplicationRecord
  include Concerns::Pagination

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true

  has_many :invoice_items, dependent: :destroy
  has_many :transactions, through: :invoice_items

  belongs_to :merchant

  def self.items_revenue
    joins(:transactions)
    .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group('items.id')
    .order(revenue: :desc)
    .where("invoices.status = ? and transactions.result = ?", 'shipped', 'success')
  end
end
