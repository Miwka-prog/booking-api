module Booking
  module V1
    class Amenities < Booking::API
      helpers ::APIHelpers::AuthenticationHelper
      helpers ::APIHelpers::ExceptionHelper
      helpers do
        def amenity
          Amenity.find_by(id: params[:id])
        end
      end
      resource :amenities do
        before { authenticate! }
        desc 'Create amenity for apartment'
        params do
          requires :name, type: String, allow_blank: false
        end
        post do
          authorize Amenity, :create?
          { amenity: AmenityProcessing::Creator.create!(declared(params)),
            message: 'Amenity created successfully' }
        end
        desc 'Delete amenity'
        route_param :id do
          delete do
            current_amenity = amenity
            if current_amenity.present?
              authorize current_amenity, :destroy?
              { amenity: AmenityProcessing::Destroyer.destroy!(current_amenity),
                message: 'Amenity deleted successfully' }
            else
              not_found
            end
          end
        end
      end
    end
  end
end
