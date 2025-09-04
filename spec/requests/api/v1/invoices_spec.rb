# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/invoices', type: :request do
  let(:path) { '/api/v1/invoices' }
  let(:create_records) { create_list(:invoice, 35) }
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  it_behaves_like 'paginated'

  it 'returns expected fields for each invoice' do
    create_records
    get path
    expect(response).to have_http_status(:ok)
    json[:data].each do |row|
      expect(row).to include(:id, :invoice_number, :total, :invoice_date, :status, :active)
    end
  end
end
