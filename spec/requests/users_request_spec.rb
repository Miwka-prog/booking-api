require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user) }
  let(:headers) { get_headers(user.email, user.password) }

  describe 'POST /api/v1/add_card' do
    let!(:params) do
      { number: '4242424242424242', exp_month: 9, exp_year: 2022, cvc: 111 }
    end

    context 'with added card' do
      it 'returns card' do
        post '/api/v1/add_card', headers: headers, params: params.to_json
        expect(JSON.parse(response.body)['last4']).to eq('4242')
      end
    end
  end
end
