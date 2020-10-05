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
      let!(:like) { FactoryBot.create(:like, user: user, product: product) }

      it 'likeが返ってくること' do
        expect(product.get_like_by(user)).to eq(like)
      end

    end

    context '特定のproductとuserに紐付いたlikeのレコードが取れない場合' do
      let(:owner) { FactoryBot.create(:user) }

      before do
        FactoryBot.create(:like, user: user, product: product)
      end

      it 'likeのレコードが返ってこないこと' do
        expect(product.get_like_by(owner)).to be_nil
      end

    end
  end

  describe '#change_status' do
    context '特定のproductの投資額が満たされている場合' do
      let!(:product) { FactoryBot.create(:product, user: user, status: 0, goal_price: 1000) }

      before do
        FactoryBot.create(:investment, user: user, product: product)
        product.change_status
      end

      it 'completeになること' do
        expect(product.complete?).to be_truthy
      end
    end

    context '特定のproductの投資額が満たされていない場合' do
      let!(:product) { FactoryBot.create(:product, user: user, status: 0, goal_price: 1500) }

      before do
        FactoryBot.create(:investment, user: user, product: product)
        product.change_status
      end

      it 'activeになること' do
        expect(product.active?).to be_truthy
      end
    end
  end

  describe '#search(query)' do

    context '検索ワードがタイトルにマッチする場合' do
      let!(:product1) { FactoryBot.create(:product, user: user, title: 'sample') }
      let!(:product2) { FactoryBot.create(:product, user: user, title: 'sam') }
      let!(:product3) { FactoryBot.create(:product, user: user, title: 's') }

      it 'タイトルにマッチするプロダクトの取得' do
        expect(Product.search({ search: "s"}).count).to eq 3
      end
    end

    context '検索ワードがgoal_priceにマッチする場合'do

    let!(:product1) { FactoryBot.create(:product, user: user, goal_price: 3000) }
    let!(:product2) { FactoryBot.create(:product, user: user, goal_price: 1000) }

      it 'goal_priceにマッチするプロダクトの取得'do
      expect(Product.search({ goal_price: 3000}).count).to eq 1
      end
    end

  context '検索ワードがカテゴリーにマッチする場合' do

    before do
      FactoryBot.create(:product)
    end

    it 'カテゴリーがマッチするプロダクトの取得' do
      expect(Product.search({ category_id: "1"}).count).to eq 1
    end
  end

  context '検索ワードがどれにもマッチしない場合' do

    it '' do
    end
  end
end
end