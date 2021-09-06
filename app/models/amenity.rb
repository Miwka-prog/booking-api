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
class Amenity < ApplicationRecord
  has_many :apartment_amenities
  has_many :apartments, through: :apartment_amenities
end
