require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) { create(:user) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'post #login' do
    it 'response is successful' do
      @request.headers['HTTP_JWT_AUD'] = 'test'
      post :create, params: { user: { email: user.email, password: user.password } }
      expect(response).to be_successful
    end
  end
end