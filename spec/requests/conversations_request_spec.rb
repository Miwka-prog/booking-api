require 'rails_helper'

RSpec.describe 'Conversations CRUD', type: :request do
  let!(:user_sender) { create(:user) }
  let!(:user_recipient) { create(:user) }
  let(:conversation) { create(:conversation, sender: user_sender, recipient: user_recipient) }
  let(:headers) { get_headers(user_sender.email, user_sender.password) }

  describe 'GET /api/v2/conversations' do
    context 'when we have conversations' do
      before do
        get '/api/v2/conversations', headers: headers
      end

      it 'returns success code' do
        expect(response).to have_http_status(:ok)
      end

      it 'return all conversations' do
        conversation = Conversation.all
        expect(JSON.parse(response.body)['conversations']).to eq(JSON.parse(conversation.to_json))
      end
    end
  end

  describe 'POST /api/v2/conversations' do
    let(:valid_params) { { recipient_id: user_recipient.id } }

    before do
      post '/api/v2/conversations', params: valid_params.to_json, headers: headers
    end

    context 'with valid params' do
      it 'creates a new conversation' do
        expect(JSON.parse(response.body)['conversation']['recipient_id']).to eq(user_recipient.id)
      end

      it 'returns 201 status' do
        expect(response.status).to eq(201)
      end
    end
  end
end
