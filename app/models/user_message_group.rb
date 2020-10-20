class UserMessageGroup < ApplicationRecord
  belongs_to :message_group
  belongs_to :user
end
