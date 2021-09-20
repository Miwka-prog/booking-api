# == Schema Information
#
# Table name: apartments
#
#  id              :bigint           not null, primary key
#  address         :string           default("")
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
  has_many :booking_apartment

  mount_uploaders :photos, ApartmentUploader

  scope :filter_by_city, ->(city) { where city: city }
end
