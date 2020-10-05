FactoryBot.define do
  factory :product do
    title { "test" }
    desc { "test1" }
    association :user

    after(:build) do |product|
      category = create(:category)
      product.product_categories << build(:product_category, product: product, category: category)
    end
  end
end