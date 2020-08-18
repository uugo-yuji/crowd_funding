require 'rails_helper'

RSpec.describe Product, type: :model do
    let(:user) { FactoryBot.create(:user) }
    let(:owner) { FactoryBot.create(:user) }
    let(:product) { FactoryBot.create(:product) }
    let(:my_product) { FactoryBot.create(:product, user: user) }
    let(:like) { FactoryBot.create(:like, user_id: user.id, product_id: my_product.id) }

  describe '#owner?(user)' do
    it "tureになること" do
      expect(my_product.owner?(user)).to eq(true)
    end

    it "falseになること" do
      expect(product.owner?(user)).to eq(false)
    end
  end

  describe '#liked?(user)' do
    it "trueになること" do
      expect(like.product.liked?(user)).to eq(true)
    end

    it "falseになること" do
      expect(like.product.liked?(owner)).to eq(false)
    end
  end

  describe '#get_like_by(user)' do
    it 'likeテーブルの主キーが返ってくること' do
      expect(like.product.get_like_by(user).id).to eq(like.id)
    end
  end

end