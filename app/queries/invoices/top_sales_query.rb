# frozen_string_literal: true

module Invoices
  module TopSalesQuery
    def self.call(limit: 10)
      Invoice
        .group('DATE(invoice_date)')
        .order('SUM(total) DESC')
        .limit(limit)
        .pluck('DATE(invoice_date) as day', 'SUM(total) AS total_sales')
        .map { |row| { date: Date.parse(row[0].to_s), total_sales: row[1] } }
    end
  end
end
