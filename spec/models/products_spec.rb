require 'rails_helper'

RSpec.describe Product, type: :model do
    let(:user) { FactoryBot.create(:user) }
    let(:product) { FactoryBot.create(:product) }

  describe '#owner?(user)' do
    it "tureになること" do
      product = user.products.build(
        title: "test",
        desc: "test1",
        user_id: user.id
      )
      expect(product.owner?(user)).to eq(true)
    end

    it "falseになること" do
      expect(product.owner?(user)).to eq(false)
    end
  end

end