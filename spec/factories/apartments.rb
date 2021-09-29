# == Schema Information
#
# Table name: apartments
#
#  id              :bigint           not null, primary key
#  address         :string           default("")
#  apartment_type  :integer          default("unknown")
#  bathrooms       :integer          default(0)
#  bedrooms        :integer          default(0)
#  beds            :integer          default(0)
#  city            :string           default("")
#  country         :string           default("")
#  description     :string           default("")
#  photos          :json
#  price_per_night :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer          not null
#
# Indexes
#
#  index_apartments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :apartment do
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    country { Faker::Address.country }
    price_per_night { Faker::Commerce.price }
  end
end
