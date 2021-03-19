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

    context 'タイトルでの検索の場合' do

      before do
        FactoryBot.create(:product, user: user, title: 'sample')
      end

      it 'タイトルの検索条件を満たす結果が取得できること' do
        expect(Product.search({ search: "s" }).count).to eq 1
      end

      it 'タイトルの検索条件を満たさない結果は取得できないこと' do
        expect(Product.search({ search: "a" }).count).to eq 0
      end
    end

    context '金額での検索の場合'do

      before do
        FactoryBot.create(:product, user: user, goal_price: 3000)
      end

      it '金額の検索条件を満たす結果が取得できること' do
        expect(Product.search({ goal_price: 3000 }).count).to eq 1
      end

      it '金額の検索条件を満たさない結果は取得できないこと' do
        expect(Product.search({ goal_price: 10000 }).count).to eq 0
      end
    end

  context 'カテゴリーでの検索の場合' do

    before do
      category = FactoryBot.create(:category) 
      FactoryBot.create(:product_category, product: product, category: category)
    end

    it 'カテゴリーの検索条件を満たす結果が取得できること' do
      expect(Product.search({ category_id: "1" }).count).to eq 1
    end

    it 'カテゴリーの検索条件を満たさない結果は取得できないこと' do
      expect(Product.search({ category_id: "2" }).count).to eq 0
    end
  end

    context '複合検索の場合' do

      context 'タイトルと金額が検索条件の場合' do

        before do
          product1 = FactoryBot.create(:product, user: user, title: 'sample', goal_price: 3000)
          product2 = FactoryBot.create(:product, user: user, title: 'system', goal_price: 3000)
          product3 = FactoryBot.create(:product, user: user, title: 'test', goal_price: 1000)
        end

        it 'タイトルと金額の検索条件を満たす結果が取得できること' do
          expect(Product.search({ title: 's', goal_price: 3000 }).count).to eq 2
        end
      end
    
      context 'タイトルとカテゴリーが検索条件の場合' do


        before do
          product1 = FactoryBot.create(:product, user: user, title: 'sample')
          product2 = FactoryBot.create(:product, user: user, title: 'system')
          product3 = FactoryBot.create(:product, user: user, title: 'test')
          category = FactoryBot.create(:category)
          FactoryBot.create(:product_category, product: product1, category: category)
          FactoryBot.create(:product_category, product: product2, category: category)
        end

        it 'タイトルとカテゴリーの検索条件を満たす結果が取得できること' do
          expect(Product.search({ title: 's', category_id: "1" }).count).to eq 2
        end
      end
    
      context '金額とカテゴリーが検索条件の場合' do

        before do
          product1 = FactoryBot.create(:product, user: user, title: 'test' ,goal_price: 3000)
          product2 = FactoryBot.create(:product, user: user, title: 'sample' ,goal_price: 3000)
          product3 = FactoryBot.create(:product, user: user, title: 'system' ,goal_price: 1000)
          category = FactoryBot.create(:category)
          FactoryBot.create(:product_category, product: product1, category: category)
          FactoryBot.create(:product_category, product: product2, category: category)
        end

        it '金額とカテゴリーの検索条件を満たす結果が取得できること' do
          expect(Product.search({ goal_price: 3000, category_id: "1" }).count).to eq 2
        end
      end
    
      context '全ての項目が検索条件の場合' do

        before do
          product1 = FactoryBot.create(:product, user: user, title: 'sample', goal_price: 3000)
          product2 = FactoryBot.create(:product, user: user, title: 'system', goal_price: 3000)
          product3 = FactoryBot.create(:product, user: user, title: 'test', goal_price: 1000)
          category = FactoryBot.create(:category)
          FactoryBot.create(:product_category, product: product1, category: category)
          FactoryBot.create(:product_category, product: product2, category: category)
        end

        it 'タイトル,金額,カテゴリー全項目の検索条件を満たす結果が取得できること' do
          expect(Product.search({ search: "s", goal_price: 3000, category_id: "1" }).count).to eq 2
        end
      end
    end
  end

  describe '#investments_user?(user)' do
    context '特定のProductに対し投資したユーザの場合' do

      before do
        FactoryBot.create(:investment, product: product, user: user)
      end

      it 'trueになること' do
        expect(product.investments_user?(user)).to be_truthy
      end
    end

    context '特定のProductに対し投資していないユーザの場合' do
      let(:owner) { FactoryBot.create(:user) }

      before do
        FactoryBot.create(:investment, product: product, user: user)
      end

      it 'falseになること' do
        expect(product.investments_user?(owner)).to be_falsey
      end
    end
  end

end