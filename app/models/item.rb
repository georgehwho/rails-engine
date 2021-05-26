class Item < ApplicationRecord
  include Concerns::Pagination

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true

  has_many :invoice_items, dependent: :destroy

  belongs_to :merchant
end
