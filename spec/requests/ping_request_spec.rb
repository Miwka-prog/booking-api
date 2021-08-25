require 'rails_helper'

RSpec.describe "Pings", type: :request do
  let!(:user) { create(:user) }

  describe 'check auth' do
    it 'Returns a status of 200' do
      get '/ping/'
      expect(response).to have_http_status(200)
    end

    it 'Returns a status of 401 if not logged in' do
      get '/ping/auth/'
      expect(response).to have_http_status(401)
    end

    it 'Returns a status of 200 if logged in' do
      headers = get_headers(user.email, user.password)
      get '/ping/auth/', headers: headers
      expect(response).to have_http_status(200)
    end
  end
end
