# == Schema Information
#
# Table name: apartment_amenities
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  amenity_id   :bigint           not null
#  apartment_id :bigint           not null
#
# Indexes
#
#  index_apartment_amenities_on_amenity_id    (amenity_id)
#  index_apartment_amenities_on_apartment_id  (apartment_id)
#
# Foreign Keys
#
#  fk_rails_...  (amenity_id => amenities.id)
#  fk_rails_...  (apartment_id => apartments.id)
#
FactoryBot.define do
  factory :apartment_amenity do
    association :amenity, factory: :amenity
    association :apartment, factory: :apartment
  end
end
