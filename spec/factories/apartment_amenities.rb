FactoryBot.define do
  factory :apartment_amenity do
    association :amenity, factory: :amenity
    association :apartment, factory: :apartment
  end
end
