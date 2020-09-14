class Product < ApplicationRecord
  belongs_to :user
  has_many :investments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

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

  def price_goal?
    if self.goal_price >= investment_sum
      complete!
    else
      active!
    end
  end

  def investment_sum
    self.investments.all.sum(:price)
  end

end
