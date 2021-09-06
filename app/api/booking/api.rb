module Booking
  class API < Grape::API
    format :json
    prefix :api
    version 'v1', using: :path

    mount Booking::V1::Apartments
    mount Booking::V1::Apartments::Comments
  end
end
