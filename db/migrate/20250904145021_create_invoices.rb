# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.string :invoice_number
      t.decimal :total, precision: 10, scale: 2
      t.datetime :invoice_date
      t.string :status
      t.boolean :active

      t.timestamps
    end
  end
end
