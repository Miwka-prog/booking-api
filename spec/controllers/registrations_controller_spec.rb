require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  let(:valid_user_params) do
    {
      email: 'poasd@test.com',
      password: '12345678',
      password_confirmation: '12345678'
    }
  end

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'post #create' do
    it 'response is successful' do
      post :create, params: { user: valid_user_params }
      expect(response).to be_successful
      expect(User.count).to eq 1
      expect(User.first.email).to eq valid_user_params[:email]
    end
  end
end
