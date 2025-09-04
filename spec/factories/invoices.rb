# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    invoice_number { 'MyString' }
    total { '9.99' }
    invoice_date { Time.zone.now }
    status { 'MyString' }
    active { false }
  end
end
