class Investment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :price, numericality: { only_integer: true }
end
