FactoryBot.define do
  factory :invoice do
    merchant { nil }
    customer { nil }
    status { "shipped" }
  end
end
