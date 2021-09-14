require 'rails_helper'
RSpec.describe 'Booking apartment', type: :request do
  let!(:user) { create(:user) }
  let!(:guest) { create(:user) }
  let(:headers_guest) { get_headers(guest.email, guest.password) }
  let(:headers_user) { get_headers(user.email, user.password) }
  let(:apartment) { create(:apartment, user_id: user.id) }
  let(:booking_apartment) do
    create(:booking_apartment, apartment_id: apartment.id, user_id: user.id,
                               total_price: 200)
  end

  describe 'POST /api/v1/apartments/:apartment_id/booking_apartment' do
    let(:valid_params) do
      { start_date: Date.new(2020, 0o1, 0o1), end_date: Date.new(2020, 0o1, 0o3),
        apartment_id: apartment.id, user_id: user.id }
    end

    context 'with valid params' do
      before do
        post "/api/v1/apartments/#{apartment.id}/booking_apartments", params: valid_params.to_json,
                                                                      headers: headers_guest
      end

      it 'creates a new booking of apartment' do
        expect(JSON.parse(response.body)['booking_apartment']['apartment_id']).to eq(apartment.id)
      end

      it 'returns 201 status' do
        expect(response.status).to eq(201)
      end
    end

    context 'with invalid params' do
      it 'returns empty end_date error' do
        valid_params[:end_date] = ''
        post "/api/v1/apartments/#{apartment.id}/booking_apartments", params: valid_params.to_json,
                                                                      headers: headers_guest
        expect(JSON.parse(response.body)['error']).to eq('end_date is empty')
      end
    end

    context 'with apartment owner' do
      it 'returns message error' do
        post "/api/v1/apartments/#{apartment.id}/booking_apartments", params: valid_params.to_json,
                                                                      headers: headers_user
        expect(JSON.parse(response.body)['message']).to eq("You can't book your own apartment!")
      end
    end
  end

  describe 'DELETE /apartments/:apartment_id/booking_apartments/:id' do
    context 'with valid apartment ID' do
      it 'deletes the booking apartment' do
        delete "/api/v1/apartments/#{apartment.id}/booking_apartments/#{booking_apartment.id}", headers: headers_guest
        expect(JSON.parse(response.body)['message']).to eq('Booking apartment deleted successfully')
      end
    end

    context 'with invalid apartment ID' do
      it 'deletes the apartment' do
        delete '/api/v1/apartments/1000/comments/1', headers: headers_guest
        expect(JSON.parse(response.body)['error']).to eq('Record Not Found')
      end
    end
  end

  describe 'PUT /api/v1/apartments/:apartment_id/booking_apartments/:id' do
    context 'with valid params' do
      let!(:booking_apartment_attrs) do
        { end_date: Date.new(2020, 0o1, 0o4) }
      end

      it 'updates the existing record' do
        put "/api/v1/apartments/#{apartment.id}/booking_apartments/#{booking_apartment.id}",
            params: booking_apartment_attrs.to_json, headers: headers_guest
        expect(booking_apartment.reload.end_date).to eq(booking_apartment_attrs[:end_date])
      end

      it 'returns success response' do
        put "/api/v1/apartments/#{apartment.id}/booking_apartments/#{booking_apartment.id}",
            params: booking_apartment_attrs.to_json, headers: headers_guest
        expect(JSON.parse(response.body)['message']).to eq('Booking apartment updated successfully')
      end
    end
  end
end
