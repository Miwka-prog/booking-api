module Grapes
  module V1
    class Apartments < Grapes::API
      helpers do
        def apartment
          Apartment.find_by(id: params[:id])
        end
      end
      resources :apartments do
        desc 'Return all apartments'
        get do
          apartments = Apartment.all
          { apartments: apartments }
        end

        desc 'Return specific apartment'
        route_param :id, type: Integer do
          get do
            specific_apartment = apartment
            if specific_apartment.present?
              { apartment: specific_apartment }
            else
              error!('Record Not Found', 404)
            end
          end
        end

        desc 'Creates a apartment object'
        params do
          requires :address, type: String, allow_blank: false
          requires :city, type: String, allow_blank: false
          requires :country, type: String, allow_blank: false
          requires :price_per_night, type: Float
          requires :user_id, type: Integer
          optional :description, type: String
        end
        post do
          { apartment: ApartmentProcessing::Creator.create!(declared(params)),
            message: 'Apartment created successfully' }
        end

        desc 'Update existing apartment object'
        params do
          requires :address, type: String, allow_blank: false
          requires :city, type: String, allow_blank: false
          requires :country, type: String, allow_blank: false
          requires :price_per_night, type: Float
          requires :user_id, type: Integer
          optional :description, type: String
        end
        route_param :id do
          put do
            apartment_for_update = apartment
            if apartment_for_update.present?
              { apartment: ApartmentProcessing::Updater.update!(params[:id], declared(params)),
                message: 'Apartment updated successfully' }
            else
              error!('Record Not Found', 404)
            end
          end
        end
        desc 'Deletes existing apartment object'
        route_param :id, type: Integer do
          delete do
            apartment_for_destroy = apartment
            if apartment_for_destroy.present?
              ApartmentProcessing::Destroyer.destroy!(apartment_for_destroy)
              { message: 'Apartment deleted successfully' }
            else
              error!('Record Not Found', 404)
            end
          end
        end
      end
    end
  end
end
