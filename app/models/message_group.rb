class MessageGroup < ApplicationRecord
  belongs_to :product
  has_many :messages
  has_many :user_message_groups
end
