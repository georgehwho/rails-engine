FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "item #{n}" }
    description { "MyString" }
    unit_price { 1.5 }
    merchant { nil }
  end
end
