require 'rails_helper'
RSpec.describe 'Amenity', type: :request do
  let!(:user) { create(:user) }
  let(:headers) { get_headers(user.email, user.password) }
  let(:amenity) { create(:amenity) }

  describe 'POST /api/v1/amenities' do
    let(:valid_params) { { name: 'Name' } }

    context 'with valid params' do
      before do
        post '/api/v1/amenities', params: valid_params.to_json, headers: headers
      end

      it 'creates a new apartment' do
        expect(JSON.parse(response.body)['amenity']['name']).to eq('Name')
      end

      it 'returns 201 status' do
        expect(response.status).to eq(201)
      end
    end

    context 'with invalid params' do
      it 'returns empty content error' do
        valid_params[:name] = ''
        post '/api/v1/amenities', params: valid_params.to_json, headers: headers
        expect(JSON.parse(response.body)['error']).to eq('name is empty')
      end
    end
  end

  describe 'DELETE /amenities/:id' do
    context 'with valid apartment ID' do
      it 'deletes the amenity' do
        delete "/api/v1/amenities/#{amenity.id}", headers: headers
        expect(JSON.parse(response.body)['message']).to eq('Amenity deleted successfully')
      end
    end
  end
end
