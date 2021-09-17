# == Schema Information
#
# Table name: conversations
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  has_many :messages, dependent: :destroy

  scope :involving, lambda { |current_user|
    where('conversations.sender_id = ? OR conversations.recipient_id = ?', current_user.id, current_user.id)
  }

  scope :between, lambda { |sender_id, recipient_id|
    where("(conversations.sender_id = ? AND   conversations.recipient_id =?) OR
(conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id, recipient_id, recipient_id, sender_id)
  }
end
