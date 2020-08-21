require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product) }

  describe '#owner?(user)' do
    context 'ユーザがオーナーの場合' do
      let(:product) { FactoryBot.create(:product, user: user) }

      it "tureになること" do
        expect(product.owner?(user)).to be_truthy
      end
    end

    context 'ユーザがオーナーではない場合' do
      it "falseになること" do
        expect(product.owner?(user)).to be_falsey
      end
    end

  end

  describe '#liked?(user)' do
    context 'プロダクトいいねが存在する場合' do
      before do
        FactoryBot.create(:like, user: user, product: product)
      end
    
      it "trueになること" do
        expect(product.liked?(user)).to be_truthy
      end
    end
    
    context 'プロダクトいいねが存在しない場合' do
      let(:owner) { FactoryBot.create(:user) }

      before do
        FactoryBot.create(:like, user: user, product: product)
      end

      it "falseになること" do
        expect(product.liked?(owner)).to be_falsey
      end
    end
  end

  describe '#get_like_by(user)' do
    context '特定のproductとuserに紐付いたlikeのレコードが取れる場合' do
      before do
        @like = FactoryBot.create(:like, user: user, product: product)
      end

      it 'likeが返ってくること' do
        expect(product.get_like_by(user)).to eq(@like)
      end

    end

    context '特定のproductとuserに紐付いたlikeのレコードが取れない場合' do
      let(:my_product) { FactoryBot.create(:product, user: user) }

      before do
        FactoryBot.create(:like, user: user, product: product)
      end

      it 'likeのレコードが返ってこないこと' do
        expect(my_product.get_like_by(user)).to be_nil
      end

    end
  end

end