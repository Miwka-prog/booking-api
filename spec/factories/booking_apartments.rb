# == Schema Information
#
# Table name: booking_apartments
#
#  id           :bigint           not null, primary key
#  end_date     :datetime
#  start_date   :datetime
#  total_price  :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  apartment_id :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_booking_apartments_on_apartment_id  (apartment_id)
#  index_booking_apartments_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (apartment_id => apartments.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :booking_apartment do
    end_date { Date.new(2020, 0o1, 0o5) }
    start_date { Date.new(2020, 0o1, 0o1) }
  end
end
