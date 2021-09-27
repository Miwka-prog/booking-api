require 'rails_helper'

RSpec.describe BookingApartmentMailer, type: :mailer do
  require 'rails_helper'

  describe 'show' do
    let(:user) { create(:user) }
    let(:apartment) { create(:apartment, user_id: user.id) }
    let(:mail) { described_class.with(user: user, apartment: apartment).show }

    it 'renders the headers' do
      expect(mail.subject).to eq('Enjoy Your Trip! 🚗')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['booking@mail.com'])
    end
  end
end
