# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe 'GET /api/v1/invoices', type: :request do
  let(:path) { '/api/v1/invoices' }
  let(:create_records) { create_list(:invoice, 35) }
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  it_behaves_like 'paginated'

  before do
    create_records
  end

  it 'returns expected fields for each invoice' do
    get path
    expect(response).to have_http_status(:ok)
    json[:data].each do |row|
      expect(row).to include(:id, :invoice_number, :total, :invoice_date, :status, :active)
    end
  end

  context 'with start_date and end_date filters' do
    before do
      Invoice.delete_all
      5.times do |x|
        create(:invoice, invoice_number: "INV-0#{x + 1}",
                         invoice_date: Time.zone.parse("2025-08-0#{x + 1} 10:00:00"))
      end
    end

    def body
      JSON.parse(response.body, symbolize_names: true)
    end

    context 'with both dates' do
      it 'returns only records in date range' do
        get path, params: { start_date: '2025-08-02', end_date: '2025-08-04', per_page: 10, page: 1 }
        expect(response).to have_http_status(:ok)
        expect(body[:data].length).to eq(2)
        expect(body[:data].map { |invoice| invoice[:invoice_number] }).to match_array(%w[INV-02 INV-03])
      end
    end

    context 'with only start_date' do
      it 'returns only records in with greater start_date' do
        get path, params: { start_date: '2025-08-03', per_page: 10, page: 1 }
        expect(response).to have_http_status(:ok)
        expect(body[:data].length).to eq(3)
        expect(body[:data].map { |invoice| invoice[:invoice_number] }).to match_array(%w[INV-03 INV-04 INV-05])
      end
    end

    context 'with only end_date' do
      it 'returns only records in with lower start_date' do
        get path, params: { end_date: '2025-08-03', per_page: 10, page: 1 }
        expect(response).to have_http_status(:ok)
        expect(body[:data].length).to eq(2)
        expect(body[:data].map { |invoice| invoice[:invoice_number] }).to match_array(%w[INV-01 INV-02])
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
