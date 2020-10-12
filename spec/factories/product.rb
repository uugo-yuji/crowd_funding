FactoryBot.define do
  factory :product do
    title { "test" }
    desc { "test1" }
    goal_price { 0 }
    association :user
  end
end