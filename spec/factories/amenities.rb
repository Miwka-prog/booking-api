# == Schema Information
#
# Table name: amenities
#
#  id         :bigint           not null, primary key
#  available  :boolean
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :amenity do
    name { Faker::House.furniture }
  end
end
