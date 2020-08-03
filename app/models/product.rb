class Product < ApplicationRecord
  belongs_to :user
  has_many :investments, dependent: :destroy

  def owner?(user)
    return self.user_id == user
  end
end
