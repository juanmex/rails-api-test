# frozen_string_literal: true

module Invoices
  module TopMorningSalesQuery
    def self.call(limit: 10)
      Invoice
        .where('EXTRACT(HOUR FROM invoice_date) BETWEEN ? AND ?', 6, 12)
        .group('DATE(invoice_date)')
        .order('SUM(total) DESC')
        .limit(limit)
        .pluck('DATE(invoice_date) AS day', 'SUM(total) AS total_sales')
        .map { |row| { date: row[0], total_sales: row[1] } }
    end
  end
end
