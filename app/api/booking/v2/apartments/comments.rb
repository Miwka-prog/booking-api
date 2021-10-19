module Booking
  module V2
    class Apartments::Comments < Booking::API
      helpers ::APIHelpers::AuthenticationHelper
      helpers ::APIHelpers::ExceptionHelper
      helpers do
        def apartment
          Apartment.find_by(id: params[:apartment_id])
        end

        def comment
          Comment.find_by(id: params[:id])
        end
      end
      namespace 'apartments/:apartment_id' do
        resource :comments do
          desc 'Return all comments of the apartments'
          params do
            requires :apartment_id, type: Integer
          end
          get do
            current_apartment = apartment
            if current_apartment.present?
              { comments: current_apartment.comments }
            else
              not_found
            end
          end
          namespace do
            before { authenticate! }
            desc 'Create comment for apartment'
            params do
              requires :apartment_id, type: Integer
              requires :content, type: String, allow_blank: false
            end
            post do
              current_apartment = apartment
              if current_apartment.present?
                authorize Comment, :create?
                { comment: CommentProcessing::Creator.create!(declared(params).merge(user_id: current_user.id)),
                  message: 'Comment created successfully' }
              else
                not_found
              end
            end
            desc 'Update comment for apartment'
            params do
              requires :apartment_id, type: Integer
              requires :content, type: String, allow_blank: false
            end
            route_param :id do
              put do
                current_comment = comment
                if current_comment.present?
                  authorize current_comment, :update?
                  { comment: CommentProcessing::Updater.update!(params[:id],
                                                                declared(params).merge(user_id: current_user.id)),
                    message: 'Comment updated successfully' }
                else
                  not_found
                end
              end
            end
            desc 'Delete comment for apartment'
            params do
              requires :apartment_id, type: Integer
            end
            route_param :id do
              delete do
                current_comment = comment
                if current_comment.present?
                  authorize current_comment, :destroy?
                  { comment: CommentProcessing::Destroyer.destroy!(current_comment),
                    message: 'Comment deleted successfully' }
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
end
