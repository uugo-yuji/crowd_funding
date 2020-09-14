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

  def change_status
    if self.goal_price >= investments.sum(:price)
      complete!
    else
      active!
    end
  end

end
