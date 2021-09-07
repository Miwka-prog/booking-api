require 'rails_helper'
RSpec.describe 'Amenity', type: :request do
  let!(:user) { create(:user) }
  let(:headers) { get_headers(user.email, user.password) }
  let(:apartment) { create(:apartment, user_id: user.id) }
  let(:apartment_amenity) { ApartmentAmenity.create(apartment_id: apartment.id, amenity_id: create(:amenity).id) }

  describe 'POST /api/v1/apartments/:apartment_id/apartment_amenities' do
    let(:valid_params) { { amenity_id: create(:amenity).id } }

    context 'with valid params' do
      before do
        post "/api/v1/apartments/#{apartment.id}/apartment_amenities", params: valid_params.to_json, headers: headers
      end

      it 'creates a new apartment' do
        expect(JSON.parse(response.body)['apartment_amenity']['amenity_id']).to eq(valid_params[:amenity_id])
      end

      it 'returns 201 status' do
        expect(response.status).to eq(201)
      end
    end

    context 'with invalid params' do
      it 'returns empty content error' do
        valid_params[:amenity_id] = ''
        post "/api/v1/apartments/#{apartment.id}/apartment_amenities", params: valid_params.to_json, headers: headers
        expect(JSON.parse(response.body)['error']).to eq('Record Not Found')
      end
    end
  end

  describe 'DELETE /apartments/:apartment_id/apartment_amenities/:id' do
    context 'with valid apartment ID' do
      it 'deletes the apartment amenity' do
        delete "/api/v1/apartments/#{apartment.id}/apartment_amenities/#{apartment_amenity.id}", headers: headers
        expect(JSON.parse(response.body)['message']).to eq('Apartment amenity deleted successfully')
      end
    end

    context 'with invalid apartment ID' do
      it 'deletes the apartment' do
        delete '/api/v1/apartments/1000/apartment_amenities/1', headers: headers
        expect(JSON.parse(response.body)['error']).to eq('Record Not Found')
      end
    end
  end
end
