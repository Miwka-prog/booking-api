require 'rails_helper'

RSpec.describe AmenityPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:admin) { create(:user) }
  let(:amenity) { create(:amenity) }

  before do
    admin.remove_role :user
    admin.add_role :admin
  end

  permissions :create? do
    context 'when auth user' do
      it 'grants access if user admin' do
        expect(subject).to permit(admin)
      end

      it 'no access if user present' do
        expect(subject).not_to permit(user)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user) }
    end
  end

  permissions :destroy? do
    context 'when auth user' do
      it 'grants access if user admin' do
        expect(subject).to permit(admin, amenity)
      end

      it 'no access if user present' do
        expect(subject).not_to permit(user, amenity)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user, amenity) }
    end
  end
end
