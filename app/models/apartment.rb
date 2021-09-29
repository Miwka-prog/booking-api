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
class Apartment < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :apartment_amenities
  has_many :amenities, through: :apartment_amenities
  has_many :booking_apartment, dependent: :destroy

  enum apartment_type: { unknown: 0, apartment: 1, hostel: 2 }

  validates :apartment_type, inclusion: { in: Apartment.apartment_types.keys }

  mount_uploaders :photos, ApartmentUploader

  scope :filter_by_city, ->(city) { where city: city }
  scope :sorted_by, lambda { |sort_option|
    direction = /desc$/.match?(sort_option) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^price/
      order("price_per_night #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }
  scope :filter_by_type, ->(type) { where apartment_type: type }
  scope :filter_by_rooms_and_beds, lambda { |filter_option, number|
    where("#{filter_option} >= #{number}")
  }
end
