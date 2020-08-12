FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "testname#{n}"}
    sequence(:email) { |n| "test#{n}@example.com"}
    sequence(:phone_number) { |n| "#{n}"}
    password { "123456" }
  end
end