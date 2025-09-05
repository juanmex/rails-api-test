# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    invoice_number { 'INV-000' }
    total { '9.99' }
    invoice_date { Time.zone.now }
    status { 'MyString' }
    active { false }
  end
end
