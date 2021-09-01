require 'rails_helper'

RSpec.describe 'Apartments', type: :request do
  describe 'GET /apartments' do
    let!(:apartment) { create(:apartment, user: create(:user)) }

    it 'returns success code' do
      get '/api/v1/apartments'
      expect(response).to have_http_status(:ok)
    end

    it 'return all apartments' do
      apartments = Apartment.all
      get '/api/v1/apartments'
      expect(JSON.parse(response.body)["apartments"]).to eq(JSON.parse(apartments.to_json))
    end

    it 'returns specific apartment for a valid id' do
      apartment = Apartment.first
      get "/api/v1/apartments/#{apartment.id}"
      expect(JSON.parse(response.body)["apartment"]).to eq(JSON.parse(apartment.to_json))
    end

    it 'returns 404 status for an invalid id' do
      get '/api/v1/apartments/1000'
      expect(response).to have_http_status(:not_found)
    end

    it 'returns record not found error for an invalid id' do
      get '/api/v1/apartments/1000'
      expect(JSON.parse(response.body)['error']).to eq('Record Not Found')
    end
  end

  describe 'POST /apartments' do
    let!(:params) do
      { address: 'Address', city: 'City', country: 'Country', price_per_night: 10.5, user_id: create(:user).id }
    end

    context 'with valid params' do
      it 'creates a new apartment' do
        post '/api/v1/apartments', params: params
        expect(JSON.parse(response.body)['apartment']['city']).to eq('City')
      end

      it 'returns 201 status' do
        post '/api/v1/apartments', params: params
        expect(response.status).to eq(201)
      end
    end

    context 'with invalid params' do
      it 'returns empty title error' do
        params[:city] = ''
        post '/api/v1/apartments', params: params
        puts response.body.inspect
        expect(JSON.parse(response.body)['error']).to eq('city is empty')
      end

      it 'returns validation error' do
        params.delete(:city)
        post '/api/v1/apartments', params: params
        puts response.body.inspect
        expect(JSON.parse(response.body)['error']).to eq('city is missing, city is empty')
      end
    end
  end

  describe 'PUT /apartments/:id' do
    let!(:apartment) { create(:apartment, user: create(:user)) }
    let!(:apartment_attrs) do
      { country: apartment.country, city: apartment.city, address: apartment.address,
        price_per_night: apartment.price_per_night, user_id: apartment.user_id }
    end

    context 'with valid params' do
      it 'updates the existing record' do
        put "/api/v1/apartments/#{apartment.id}", params: apartment_attrs
        expect(apartment.reload.city).to eq(apartment_attrs[:city])
      end

      it 'returns success response' do
        put "/api/v1/apartments/#{apartment.id}", params: apartment_attrs
        expect(JSON.parse(response.body)['message']).to eq('Apartment updated successfully')
      end
    end

    context 'with invalid params' do
      it 'returns validation error' do
        apartment_attrs.delete(:city)
        put "/api/v1/apartments/#{apartment.id}", params: apartment_attrs
        expect(JSON.parse(response.body)['error']).to eq('city is missing, city is empty')
      end
    end
  end

  describe 'DELETE /apartments/:id' do
    let!(:apartment) { create(:apartment, user: create(:user)) }

    context 'with valid apartment ID' do
      it 'deletes the apartment' do
        delete "/api/v1/apartments/#{apartment.id}"
        expect(JSON.parse(response.body)['message']).to eq('Apartment deleted successfully')
      end
    end

    context 'with invalid apartment ID' do
      it 'deletes the apartment' do
        delete '/api/v1/apartments/1000'
        expect(JSON.parse(response.body)['error']).to eq('Record Not Found')
      end
    end
  end
end
