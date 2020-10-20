class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :products, dependent: :destroy
  has_many :investments
  has_many :likes, dependent: :destroy
  has_many :liked_products, through: :likes, source: :products
  has_many :user_message_groups

  enum role: { general: 0, admin: 1 }

end
