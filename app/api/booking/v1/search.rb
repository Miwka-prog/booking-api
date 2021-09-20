module Booking
  module V1
    class Search < Booking::API
      resource :search do
        desc 'Search apartments by city and date'
        params do
          requires :city, type: String, allow_blank: false
          requires :country, type: String, allow_blank: false
          requires :start_date, type: Date, allow_blank: false
          requires :end_date, type: Date, allow_blank: false
        end
        post do
          apartments = Searcher.search!(declared(params))
          { apartments: apartments }
        end
      end
    end
  end
end
