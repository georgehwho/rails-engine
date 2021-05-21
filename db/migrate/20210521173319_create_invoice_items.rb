class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|
      t.belongs_to :item, foreign_key: true
      t.belongs_to :invoice, foreign_key: true
      t.integer :quantity
      t.float :unit_price

      t.timestamps
    end
  end
end
