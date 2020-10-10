class Product < ApplicationRecord
  belongs_to :user
  has_many :investments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  accepts_nested_attributes_for :product_categories, allow_destroy: true
  has_one_attached :image

  enum status: { active: 0, complete: 1 }

  validates :title, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :desc, presence: true, length: { maximum: 1000 }
  validates :goal_price, numericality: { only_integer: true }

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

end
