# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Invoices', type: :request do
  describe 'GET /invoices' do
    it 'list invoices' do
      create_list(:invoice, 2)
      get '/invoices'
      expect(response).to have_http_status(:ok)
      expect(json[:data]).to be_an(Array)
    end
  end
end
