FactoryBot.define do
  factory :investment do
    price { 1000 }
    association :user
    association :product
  end
end