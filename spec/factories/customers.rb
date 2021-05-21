FactoryBot.define do
  factory :customer do
    sequence(:first_name) { |n| "george#{n}" }
    sequence(:last_name) { |n| "ho#{n}" }
  end
end
