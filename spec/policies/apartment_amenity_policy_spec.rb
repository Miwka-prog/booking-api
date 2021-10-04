require 'rails_helper'

RSpec.describe ApartmentAmenityPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:host) { create(:user) }
  let(:admin) { create(:user) }
  let(:apartment) { create(:apartment, user: host) }
  let(:amenity) { create(:amenity) }
  let(:apartment_amenity) { create(:apartment_amenity, apartment: apartment, amenity: amenity) }

  before do
    admin.remove_role :user
    admin.add_role :admin
  end

  permissions :create? do
    context 'when auth user' do
      it 'grants access if user present' do
        expect(subject).to permit(host, apartment)
      end

      it 'don\'t grant access if user present' do
        expect(subject).not_to permit(user, apartment)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user, apartment) }
    end
  end

  permissions :destroy? do
    context 'when auth user' do
      it 'grants access if user present' do
        expect(subject).to permit(host, apartment_amenity)
      end

      it 'don\'t grant access if user present' do
        expect(subject).not_to permit(user, apartment_amenity)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user, apartment_amenity) }
    end
  end
end
