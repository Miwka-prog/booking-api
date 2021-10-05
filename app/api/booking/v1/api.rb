module Booking
  module V1
    class API < Grape::API
      format :json
      prefix :api
      version 'v1'

      mount Booking::V1::Amenities
    end
  end
end
