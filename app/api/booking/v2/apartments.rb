module Booking
  module V2
    class Apartments < Booking::API
      helpers ::APIHelpers::AuthenticationHelper
      helpers ::APIHelpers::ExceptionHelper
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
              not_found
            end
          end
        end

        namespace do
          before { authenticate! }
          desc 'Creates a apartment object'
          params do
            requires :address, type: String, allow_blank: false
            requires :city, type: String, allow_blank: false
            requires :country, type: String, allow_blank: false
            requires :price_per_night, type: Float
            optional :description, type: String
          end
          post do
            authorize Apartment, :create?
            { apartment: ApartmentProcessing::Creator.create!(declared(params).merge(user_id: current_user.id)),
              message: 'Apartment created successfully' }
          end

          desc 'Update existing apartment object'
          params do
            requires :address, type: String, allow_blank: false
            requires :city, type: String, allow_blank: false
            requires :country, type: String, allow_blank: false
            requires :price_per_night, type: Float
            optional :description, type: String
          end
          route_param :id do
            put do
              apartment_for_update = apartment
              if apartment_for_update.present?
                authorize apartment_for_update, :update?
                { apartment: ApartmentProcessing::Updater.update!(params[:id],
                                                                  declared(params).merge(user_id: current_user.id)),
                  message: 'Apartment updated successfully' }
              else
                not_found
              end
            end
          end
          desc 'Deletes existing apartment object'
          route_param :id, type: Integer do
            delete do
              apartment_for_destroy = apartment
              if apartment_for_destroy.present?
                authorize apartment_for_destroy, :destroy?
                ApartmentProcessing::Destroyer.destroy!(apartment_for_destroy)
                { message: 'Apartment deleted successfully' }
              else
                not_found
              end
            end
          end
        end
      end
    end
  end
end
