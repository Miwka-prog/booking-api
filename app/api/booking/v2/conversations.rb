module Booking
  module V2
    class Conversations < Booking::API
      helpers ::APIHelpers::AuthenticationHelper
      resources :conversations do
        before { authenticate! }
        desc 'Get all conversations'
        get do
          { conversations: Conversation.involving(current_user) }
        end
        desc 'Create conversation'
        params do
          requires :recipient_id, type: Integer
        end
        post do
          conversation = Conversation.between(current_user.id, params[:recipient_id])

          if conversation.present?
            { conversation: conversation.first }
          else
            { conversation: ConversationProcessing::Creator.create!(declared(params)
                            .merge(sender_id: current_user.id)) }
          end
        end
      end
    end
  end
end
