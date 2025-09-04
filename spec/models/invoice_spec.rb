# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'database schema' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:invoice_number).of_type(:string).with_options(null: true) }
    it { is_expected.to have_db_column(:total).of_type(:decimal) }
    it { is_expected.to have_db_column(:invoice_date).of_type(:datetime) }
    it { is_expected.to have_db_column(:status).of_type(:string) }
    it { is_expected.to have_db_column(:active).of_type(:boolean) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'factories' do
    it 'has a valid factory' do
      expect(build(:invoice)).to be_valid
    end
  end
end
