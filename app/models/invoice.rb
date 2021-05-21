class Invoice < ApplicationRecord
  validates :status, presence: true

  has_many :invoice_items, dependent: :destroy

  belongs_to :merchant
  belongs_to :customer
end
