class Investment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :price, presence: true, numericality: { only_integer: true }
end
