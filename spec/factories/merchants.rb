FactoryBot.define do
  factory :merchant do
    sequence(:name) { |n| "george shop #{n}" }
  end
end
