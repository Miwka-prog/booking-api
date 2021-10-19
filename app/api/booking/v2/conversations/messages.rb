module Booking
  module V2
    class Conversations::Messages < Booking::API
      helpers ::APIHelpers::AuthenticationHelper
      helpers ::APIHelpers::ExceptionHelper
      helpers do
        def conversation
          @conversation = current_user.conversations.find_by(id: params[:conversation_id])
          not_found if @conversation.blank?
        end
      end

      namespace 'conversations/:conversation_id' do
        resource :messages do
          before do
            authenticate!
            conversation
          end

          desc 'Get all messages of the conversation'
          params do
            requires :conversation_id, type: Integer
          end
          get do
            MessagePolicy.new(current_user, @conversation).show?
            messages = @conversation.messages.order('created_at DESC')
            { messages: messages }
          end

          desc 'Create message in the conversation'
          params do
            requires :conversation_id, type: Integer
            requires :content, type: String, allow_blank: false
          end
          post do
            MessagePolicy.new(current_user, @conversation).create?
            { message: MessageProcessing::Creator.create!(declared(params).merge(user_id: current_user.id)) }
          end
        end
      end
    end
  end
end
