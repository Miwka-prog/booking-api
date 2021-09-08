# == Schema Information
#
# Table name: comments
#
#  id           :bigint           not null, primary key
#  content      :text             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  apartment_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_comments_on_apartment_id  (apartment_id)
#  index_comments_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (apartment_id => apartments.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
FactoryBot.define do
  factory :comment do
    association :user, factory: :user
    association :apartment, factory: :apartment
    content { Faker::TvShows::FinalSpace.quote }
  end
end
