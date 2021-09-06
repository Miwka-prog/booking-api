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
  belongs_to :apartment
end
