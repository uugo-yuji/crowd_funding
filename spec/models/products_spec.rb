require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @product = FactoryBot.create(:product)
  end

  describe 'Userに紐ついているProduct' do
    it "Userに紐ついてProductの作成" do
      product = @product
      expect(product).to be_valid
    end
  end

  describe 'owner?(user)メソッド' do
    it "Productのuser_idの比較 ture" do
      user = @user
      product = user.products.build(
        title: "test",
        desc: "test1",
        user_id: user.id
      )
      expect(product.owner?(user)).to eq(true)
    end

    it "Productのuser_idの比較 false" do
      user = @user
      product = @product
      expect(product.owner?(user)).to eq(false)
    end
  end

end