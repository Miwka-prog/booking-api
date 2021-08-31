module Grapes
  module V1
    class Apartments < Grapes::API
      resources :apartments do
        desc 'Return all apartments'
        get do
          Apartment.all
        end

        desc 'Return specific apartment'
        route_param :id, type: Integer do
          get do
            Apartment.find(params[:id])
          rescue ActiveRecord::RecordNotFound
            error!('Record Not Found', 404)
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
          apartment = Apartment.create!(declared(params))
          { apartment: apartment, message: 'Apartment created successfully' }
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
            apartment = Apartment.find(params[:id])
            apartment.update(declared(params))
            { message: 'Apartment updated successfully' }
          rescue ActiveRecord::RecordNotFound
            error!('Record Not Found', 404)
          end
        end

        desc 'Deletes existing apartment object'
        route_param :id, type: Integer do
          delete do
            Apartment.find(params[:id]).delete
            { message: 'Apartment deleted successfully' }
          rescue ActiveRecord::RecordNotFound
            error!('Record Not Found', 404)
          end
        end
      end
    end
  end
end