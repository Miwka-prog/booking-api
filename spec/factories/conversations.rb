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
FactoryBot.define do
  factory :conversation do
    association :sender, factory: :user
    association :recipient, factory: :user
  end
end
