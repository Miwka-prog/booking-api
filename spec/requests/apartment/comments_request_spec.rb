require 'rails_helper'
RSpec.describe 'Comment', type: :request do
  let!(:user) { create(:user) }
  let(:headers) { get_headers(user.email, user.password) }
  let(:apartment) { create(:apartment, user_id: user.id) }
  let(:comment) { create(:comment, apartment: apartment) }

  describe 'GET /api/v2/apartments/:apartment_id/comments' do
    before do
      create_list(:comment, 4, apartment: apartment)
    end

    it 'returns success code' do
      get "/api/v2/apartments/#{apartment.id}/comments"
      expect(response).to have_http_status(:ok)
    end

    it 'return all apartments' do
      comments = Comment.all
      get "/api/v2/apartments/#{apartment.id}/comments"
      expect(JSON.parse(response.body)['comments']).to eq(JSON.parse(comments.to_json))
    end

    it 'returns 404 status for an invalid id' do
      get '/api/v2/apartments/1000/comments'
      expect(response).to have_http_status(:not_found)
    end

    it 'returns record not found error for an invalid id' do
      get '/api/v2/apartments/1000/comments'
      expect(JSON.parse(response.body)['error']).to eq('Record Not Found')
    end
  end

  describe 'POST /api/v2/apartments/:apartment_id/comments' do
    let(:valid_params) { { content: 'Comment' } }

    context 'with valid params' do
      before do
        post "/api/v2/apartments/#{apartment.id}/comments", params: valid_params.to_json, headers: headers
      end

      it 'creates a new apartment' do
        expect(JSON.parse(response.body)['comment']['content']).to eq('Comment')
      end

      it 'returns 201 status' do
        expect(response.status).to eq(201)
      end
    end

    context 'with invalid params' do
      it 'returns empty content error' do
        valid_params[:content] = ''
        post "/api/v2/apartments/#{apartment.id}/comments", params: valid_params.to_json, headers: headers
        expect(JSON.parse(response.body)['error']).to eq('content is empty')
      end
    end
  end

  describe 'PUT /api/v2/apartments/:apartment_id/comments/:id' do
    context 'with valid params' do
      let!(:comment_attrs) do
        { content: 'New comment' }
      end

      it 'updates the existing record' do
        put "/api/v2/apartments/#{apartment.id}/comments/#{comment.id}", params: comment_attrs.to_json, headers: headers
        expect(comment.reload.content).to eq(comment_attrs[:content])
      end

      it 'returns success response' do
        put "/api/v2/apartments/#{apartment.id}/comments/#{comment.id}", params: comment_attrs.to_json, headers: headers
        expect(JSON.parse(response.body)['message']).to eq('Comment updated successfully')
      end
    end
  end

  describe 'DELETE /apartments/:apartment_id/comments/:id' do
    context 'with valid apartment ID' do
      it 'deletes the comment' do
        delete "/api/v2/apartments/#{apartment.id}/comments/#{comment.id}", headers: headers
        expect(JSON.parse(response.body)['message']).to eq('Comment deleted successfully')
      end
    end

    context 'with invalid apartment ID' do
      it 'deletes the apartment' do
        delete '/api/v2/apartments/1000/comments/1', headers: headers
        expect(JSON.parse(response.body)['error']).to eq('Record Not Found')
      end
    end
  end
end
