FactoryBot.define do
  factory :transaction do
    credit_card_number { "4397199533314394" }
    credit_card_expiration_date { "12/25" }
    result { "success" }
    invoice { nil }
  end
end
