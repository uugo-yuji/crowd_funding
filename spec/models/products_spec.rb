require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @product = FactoryBot.create(:product)
  end

  describe '#owner?(user)' do
    it "tureになること" do
      user = @user
      product = user.products.build(
        title: "test",
        desc: "test1",
        user_id: user.id
      )
      expect(product.owner?(user)).to eq(true)
    end

    it "falseになること" do
      user = @user
      product = @product
      expect(product.owner?(user)).to eq(false)
    end
  end

end