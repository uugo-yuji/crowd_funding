require 'rails_helper'

RSpec.describe Product, type: :model do
    let(:user) { FactoryBot.create(:user) }
    let(:product) { FactoryBot.create(:product) }
    let(:my_product) { FactoryBot.create(:product, user: user) }

  describe '#owner?(user)' do
    it "tureになること" do
      expect(my_product.owner?(user)).to eq(true)
    end

    it "falseになること" do
      expect(product.owner?(user)).to eq(false)
    end
  end

end