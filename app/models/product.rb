class Product < ApplicationRecord
  belongs_to :user
  has_many :investments, dependent: :destroy

  def owner?(user_id)
    self.user_id == user_id
  end
end
