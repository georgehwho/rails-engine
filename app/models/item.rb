class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  has_many :invoice_items, dependent: :destroy

  belongs_to :merchant
end
