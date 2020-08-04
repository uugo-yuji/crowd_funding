class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :products, dependent: :destroy
  has_many :investments
  has_many :liked_products, through: :likes, source: :products

  def already_liked?(product)
    self.likes.exists?(product_id: product.id)
  end
end
