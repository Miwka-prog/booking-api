module Booking
  module V1
    class Apartments::ApartmentAmenities < Booking::API
      helpers ::APIHelpers::AuthenticationHelper
      helpers do
        def apartment
          Apartment.find_by(id: params[:apartment_id])
        end

        def apartment_amenity
          ApartmentAmenity.find_by(id: params[:id])
        end

        def amenity
          Amenity.find_by(id: params[:amenity_id])
        end
      end
      namespace 'apartments/:apartment_id' do
        resource 'apartment_amenities' do
          before { authenticate! }
          desc 'Create amenity for apartment'
          params do
            requires :apartment_id, type: Integer
            requires :amenity_id, type: Integer
          end
          post do
            current_apartment = apartment
            current_amenity = amenity
            if current_apartment.present? and current_amenity.present?
              { apartment_amenity: ApartmentAmenityProcessing::Creator.create!(declared(params)),
                message: 'Apartment amenity created successfully' }
            else
              error!('Record Not Found', 404)
            end
          end
          desc 'Delete comment for apartment'
          params do
            requires :apartment_id, type: Integer
          end
          route_param :id do
            delete do
              current_apartment_amenity = apartment_amenity
              if current_apartment_amenity.present?
                { apartment_amenity: ApartmentAmenityProcessing::Destroyer.destroy!(current_apartment_amenity),
                  message: 'Apartment amenity deleted successfully' }
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