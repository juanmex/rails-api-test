# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TopSalesMailer, type: :mailer do
  include ActionView::Helpers::NumberHelper

  describe '#top_sales' do
    let(:sample_data) do
      [
        { date: Date.parse('2025-09-04'), total_sales: 1234.56 },
        { date: Date.parse('2025-09-03'), total_sales: 789.0 }
      ]
    end

    let(:mail) { described_class.top_sales(sample_data) }
    it 'renders the headers' do
      expect(mail.subject).to eq('Top Morning Sales')
      expect(mail.to).to eq(['admin@contalink.com'])
      expect(mail.from).to eq(['no-reply@example.com'])
    end

    it 'renders the body with data' do
      sample_data.each do |row|
        expect(mail.body.encoded).to include(row[:date].strftime('%d/%m/%Y'))
        expect(mail.body.encoded).to include(number_to_currency(row[:total_sales]).to_s)
      end
    end
  end
end
