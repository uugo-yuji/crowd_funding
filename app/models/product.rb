class Product < ApplicationRecord
  belongs_to :user
  has_many :investments, dependent: :destroy
end
