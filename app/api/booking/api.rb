module Booking
  class API < Grape::API
    format :json
    prefix :api
    version 'v2'

    rescue_from Pundit::NotAuthorizedError do |_e|
      error! 'Access Denied', 401
    end

    helpers Pundit

    mount Booking::V1::API
    mount Booking::V2::Apartments
    mount Booking::V2::Apartments::Comments
    mount Booking::V2::Apartments::ApartmentAmenities
    mount Booking::V2::Apartments::BookingApartments
    mount Booking::V2::Conversations
    mount Booking::V2::Conversations::Messages
    mount Booking::V2::Search
    mount Booking::V2::Users
  end
end
