require 'rails_helper'

RSpec.describe 'Search', type: :request do
  let!(:users) { create_list(:user, 2) }
  let!(:apartments) { create_list(:apartment, 2, user_id: users.first.id) }
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
        post '/api/v1/search', params: params
        expect(JSON.parse(response.body)['apartments'][0]['id']).to eq(apartments.second.id)
      end
    end

    context 'with wrong date' do
      let!(:params) do
        { city: apartments.first.city, country: 'Ukraine', start_date: Date.new(2020, 10, 11),
          end_date: Date.new(2020, 10, 13) }
      end

      it 'returns second apartment with' do
        post '/api/v1/search', params: params
        expect(JSON.parse(response.body)['apartments'].count).to eq(0)
      end
    end

    context 'with wrong city' do
      let!(:params) do
        { city: 'City', country: 'Ukraine', start_date: Date.new(2020, 0o1, 0o1), end_date: Date.new(2020, 0o1, 0o4) }
      end

      it 'returns second apartment with' do
        post '/api/v1/search', params: params
        expect(JSON.parse(response.body)['apartments'].count).to eq(0)
      end
    end
  end
end
