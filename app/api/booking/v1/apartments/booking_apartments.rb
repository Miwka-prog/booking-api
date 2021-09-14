module Booking
  module V1
    class Apartments::BookingApartments < Booking::API
      helpers ::APIHelpers::AuthenticationHelper
      helpers do
        def end_date
          params['end_date'].nil? ? booking_apartment.end_date.to_date : params['end_date']
        end

        def start_date
          params['start_date'].nil? ? booking_apartment.start_date.to_date : params['start_date']
        end

        def apartment
          Apartment.find_by(id: params[:apartment_id])
        end

        def booking_apartment
          BookingApartment.find_by(id: params[:id])
        end

        def total_price
          booking_end_date = end_date
          booking_start_date = start_date
          number_nights = (booking_end_date - booking_start_date).to_i
          apartment.price_per_night * number_nights
        end
      end
      namespace 'apartments/:apartment_id' do
        resource 'booking_apartments' do
          before { authenticate! }
          desc 'Create booking for apartment'
          params do
            requires :apartment_id, type: Integer
            requires :start_date, type: Date, allow_blank: false
            requires :end_date, type: Date, allow_blank: false
          end
          post do
            current_apartment = apartment
            if current_apartment.present?
              if current_user.id == current_apartment.user.id
                { message: "You can't book your own apartment!" }
              else
                { booking_apartment: BookingApartmentProcessing::Creator.create!(declared(params)
                  .merge(user_id: current_user.id, total_price: total_price)),
                  message: 'Booking apartment created successfully' }
              end
            else
              error!('Record Not Found', 404)
            end
          end
          desc 'Delete booking for apartment'
          params do
            requires :apartment_id, type: Integer
          end
          route_param :id do
            delete do
              current_booking_apartment = booking_apartment
              if current_booking_apartment.present?
                { booking_apartment: BookingApartmentProcessing::Destroyer.destroy!(current_booking_apartment),
                  message: 'Booking apartment deleted successfully' }
              else
                error!('Record Not Found', 404)
              end
            end
          end
          desc 'Update booking for apartment'
          params do
            requires :apartment_id, type: Integer
            optional :start_date, type: Date, allow_blank: false
            optional :end_date, type: Date, allow_blank: false
          end
          route_param :id do
            put do
              current_booking_apartment = booking_apartment
              if current_booking_apartment.present?
                { booking_apartment: BookingApartmentProcessing::Updater.update!(
                  params[:id], params.merge(user_id: current_user.id, total_price: total_price)
                ),
                  message: 'Booking apartment updated successfully' }
              else
                error!('Record Not Found', 404)
              end
            end
          end
        end
      end
    end
  end
end
