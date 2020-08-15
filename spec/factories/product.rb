FactoryBot.define do
  factory :product do
    title {"test"}
    desc {"test1"}
    association :user
  end
end