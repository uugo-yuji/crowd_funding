class Product < ApplicationRecord
  belongs_to :user
  has_many :investments, dependent: :destroy

  def owner?(user)
    self.user_id == user.id
  end
end
