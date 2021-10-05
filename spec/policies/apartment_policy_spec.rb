require 'rails_helper'

RSpec.describe ApartmentPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:host) { create(:user) }
  let(:admin) { create(:user) }
  let(:apartment) { create(:apartment, user: host) }

  before do
    admin.remove_role :user
    admin.add_role :admin
  end

  permissions :create? do
    context 'when auth user' do
      it 'grants access if user admin' do
        expect(subject).to permit(admin)
      end

      it 'grants access if user present' do
        expect(subject).to permit(user)
      end

      it 'grants access if host present' do
        expect(subject).to permit(host)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user) }
    end
  end

  permissions :update? do
    context 'when auth user is a host' do
      it 'grants access if user\'s apartment' do
        expect(subject).to permit(host, apartment)
      end

      it 'deny if not user\'s comment' do
        expect(subject).not_to permit(user, apartment)
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
        expect(subject).to permit(admin, apartment)
      end

      it 'grants access if user\'s apartment' do
        expect(subject).to permit(host, apartment)
      end

      it 'deny if not user\'s apartment' do
        expect(subject).not_to permit(user, apartment)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user) }
    end
  end
end
