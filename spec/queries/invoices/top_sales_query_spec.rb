# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe Invoices::TopSalesQuery do
  describe '.call' do
    before do
      Invoice.delete_all
      create(:invoice, total: 1200.0, invoice_date: Time.zone.parse('2025-07-17 13:00'))
      create(:invoice, total: 100.00,  invoice_date: Time.zone.parse('2025-07-17 16:00'))

      create(:invoice, total: 500.00,  invoice_date: Time.zone.parse('2025-07-16 08:00'))
      create(:invoice, total: 700.00,  invoice_date: Time.zone.parse('2025-07-16 09:00'))

      create(:invoice, total: 50.00,   invoice_date: Time.zone.parse('2025-07-15 12:00'))
      create(:invoice, total: 25.00,   invoice_date: Time.zone.parse('2025-07-15 18:00'))
    end

    it 'returns date + total_sales grouped in desc order' do
      result = described_class.call(limit: 10)

      expect(result).to be_an(Array)
      expect(result.first).to include(:date, :total_sales)

      expect(result).to eq([
                             { date: Date.parse('2025-07-17'), total_sales: 1300 },
                             { date: Date.parse('2025-07-16'), total_sales: 1200 },
                             { date: Date.parse('2025-07-15'), total_sales: 75 }
                           ])
    end

    it 'respects the default limit when not provided' do
      result = described_class.call
      expect(result.length).to be <= 10
      expect(result.length).to eq(3)
    end

    it 'respects a custom limit' do
      result = described_class.call(limit: 2)
      expect(result.length).to eq(2)
      expect(result[0]).to eq({ date: Date.parse('2025-07-17'), total_sales: 1300 })
      expect(result[1]).to eq({ date: Date.parse('2025-07-16'), total_sales: 1200 })
    end

    it 'returns an empty array when there is no data' do
      Invoice.delete_all
      expect(described_class.call(limit: 5)).to eq([])
    end
  end
end
# rubocop:enable Metrics/BlockLength
