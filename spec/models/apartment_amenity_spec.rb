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
require 'rails_helper'

RSpec.describe ApartmentAmenity, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
