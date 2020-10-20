FactoryBot.define do
  factory :message do
    message_group { nil }
    user { nil }
    content { "MyString" }
  end
end
