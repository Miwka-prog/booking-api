require 'rails_helper'

RSpec.describe 'Messages CRUD', type: :request do
  let!(:user_sender) { create(:user) }
  let!(:user_recipient) { create(:user) }
  let!(:conversation) { create(:conversation, sender: user_sender, recipient: user_recipient) }

  let(:headers) { get_headers(user_sender.email, user_sender.password) }

  describe 'GET /api/v2/conversations/:conversation_id/messages' do
    context 'when we have messages' do
      before do
        create_list(:message, 4, content: 'Content', conversation: conversation, user_id: user_sender.id)
        get "/api/v1/conversations/#{conversation.id}/messages", headers: headers
      end

      it 'returns success code' do
        expect(response).to have_http_status(:ok)
      end

      it 'return all messages' do
        expect(JSON.parse(response.body)['messages'].count).to eq(4)
      end
    end
  end

  describe 'POST /api/v1/conversations/:conversation_id/messages' do
    let(:valid_params) { { content: 'Message' } }

    context 'with valid params' do
      before do
        post "/api/v1/conversations/#{conversation.id}/messages", params: valid_params.to_json, headers: headers
      end

      it 'creates a new message' do
        expect(JSON.parse(response.body)['message']['content']).to eq('Message')
      end

      it 'returns 201 status' do
        expect(response.status).to eq(201)
      end
    end
  end
end
