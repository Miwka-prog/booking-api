require 'carrierwave/test/matchers'
require 'rails_helper'

describe UserUploader do
  include CarrierWave::Test::Matchers

  let(:user) { create(:user) }
  let(:uploader) { described_class.new(user, :avatar) }

  before do
    described_class.enable_processing = true
    File.open(Rails.root.join('spec/fixtures/files/avatar.jpg')) { |f| uploader.store!(f) }
  end

  after do
    described_class.enable_processing = false
    uploader.remove!
  end

  context 'with the thumb version' do
    it 'scales down a landscape image to be exactly 100 by 100 pixels' do
      expect(uploader.thumb).to have_dimensions(100, 100)
    end
  end

  context 'with the small thumb version' do
    it 'scales down a landscape image to be exactly 20 by 20 pixels' do
      expect(uploader.small_thumb).to have_dimensions(20, 20)
    end
  end

  context 'with the default version' do
    it 'scales down a landscape image to fit within 200 by 200 pixels' do
      expect(uploader).to be_no_larger_than(200, 200)
    end
  end

  it 'has the correct format' do
    expect(uploader).to be_format('jpeg')
  end
end
