FactoryBot.define do
  factory :invoice do
    invoice_number { "INV01" }
    total { 100 }
    invoice_date { Time.zone.now }
    status { "Vigente" }
    active { true }
  end
end
