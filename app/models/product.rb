class Product < ApplicationRecord
  belongs_to :user
  has_many :investments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  accepts_nested_attributes_for :product_categories, allow_destroy: true

  enum status: { active: 0, complete: 1 }

  def owner?(user)
    self.user_id == user.id
  end

  def liked?(user)
    get_like_by(user).present?
  end

  def get_like_by(user)
    likes.find_by(user_id: user.id)
  end

  def change_status
    if self.goal_price <= investments.sum(:price)
      complete!
    else
      active!
    end
  end

  def self.search(query)
    results = all
    results = self.joins(:categories).merge(Category.where(id: query[:category_id])) if query[:category_id].present?
    results = results.where(['title LIKE ?', "#{query[:search]}%"]) if query[:search].present?
    results = results.where(goal_price: query[:goal_price]) if query[:goal_price].present?
    results
  end

end