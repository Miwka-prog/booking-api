require 'rails_helper'

RSpec.describe 'Search', type: :request do
  let!(:users) { create_list(:user, 2) }
  let!(:apartments) { create_list(:apartment, 3, user_id: users.first.id) }
  let!(:booking_apartment) do
    create(:booking_apartment, apartment_id: apartments.first.id,
                               start_date: Date.new(2020, 10, 10), end_date: Date.new(2020, 10, 12),
                               user_id: users.second.id)
  end
  let!(:booking_apartment1) do
    create(:booking_apartment, apartment_id: apartments.second.id,
                               start_date: Date.new(2020, 11, 10), end_date: Date.new(2020, 11, 12),
                               user_id: users.second.id)
  end

  describe 'POST /search' do
    context 'with right date' do
      let!(:params) do
        { city: apartments.second.city, country: 'Ukraine', start_date: Date.new(2020, 10, 11),
          end_date: Date.new(2020, 10, 13) }
      end

      it 'returns second apartment with' do
        post '/api/v2/search', params: params
        expect(JSON.parse(response.body)['apartments'][0]['id']).to eq(apartments.second.id)
      end
    end

    context 'with wrong date' do
      let!(:params) do
        { city: apartments.first.city, country: 'Ukraine', start_date: Date.new(2020, 10, 11),
          end_date: Date.new(2020, 10, 13) }
      end

      it 'returns second apartment with' do
        post '/api/v2/search', params: params
        expect(JSON.parse(response.body)['apartments'].count).to eq(0)
      end
    end

    context 'with wrong city' do
      let!(:params) do
        { city: 'City', country: 'Ukraine', start_date: Date.new(2020, 0o1, 0o1), end_date: Date.new(2020, 0o1, 0o4) }
      end

      it 'returns second apartment with' do
        post '/api/v2/search', params: params
        expect(JSON.parse(response.body)['apartments'].count).to eq(0)
      end
    end
  end

  describe 'POST /search/filter' do
    context 'with all params' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      let!(:amenities) { create_list(:amenity, 3) }
      let!(:sorted_params) { { sorted_type: 'price_desc' } }
      let!(:amenities_params) { { amenities: amenities.pluck(:name) } }
      let!(:type_params) { { apartment_type: 'hostel' } }
      let!(:rooms_and_beds_params) { { rooms_and_beds: { bedrooms: 2 } } }
      let!(:apartment_amenity) { create(:apartment_amenity, apartment: apartments.first, amenity: amenities.first) }
      let!(:apartment_amenity1) { create(:apartment_amenity, apartment: apartments.first, amenity: amenities.second) }

      it 'return one apartment' do
        post '/api/v2/search/filter', params: amenities_params
        expect(JSON.parse(response.body)['apartments'].count).to eq(1)
        expect(JSON.parse(response.body)['apartments'][0]['city']).to eq(apartments.first.city)
      end

      it 'returns apartments in order' do
        max_price = apartments.pluck(:price_per_night).max
        post '/api/v2/search/filter', params: sorted_params
        expect(JSON.parse(response.body)['apartments'][0]['price_per_night']).to eq(max_price)
      end

      it 'returns apartment with type' do
        apartments.second.update!(apartment_type: 'hostel')
        post '/api/v2/search/filter', params: type_params
        expect(JSON.parse(response.body)['apartments'][0]['city']).to eq(apartments.second.city)
      end

      it 'returns apartment with two bedrooms' do
        apartments.third.update!(beds: 2, bedrooms: 1, bathrooms: 1)
        apartments.second.update!(beds: 3, bedrooms: 2, bathrooms: 1)
        post '/api/v2/search/filter', params: rooms_and_beds_params
        expect(JSON.parse(response.body)['apartments'][0]['city']).to eq(apartments.second.city)
      end
    end
  end
end
