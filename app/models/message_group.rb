class MessageGroup < ApplicationRecord
  belongs_to :product
  has_many :messages
  has_many :user_message_groups
  has_many :users, through: :user_message_groups
end
