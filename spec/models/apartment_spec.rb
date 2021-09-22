# == Schema Information
#
# Table name: apartments
#
#  id              :bigint           not null, primary key
#  address         :string           default("")
#  apartment_type  :integer          default(0)
#  bathrooms       :integer          default(0)
#  bedrooms        :integer          default(0)
#  beds            :integer          default(0)
#  city            :string           default("")
#  country         :string           default("")
#  description     :string           default("")
#  photos          :json
#  price_per_night :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer          not null
#
# Indexes
#
#  index_apartments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
RSpec.describe Apartment, type: :model do
  describe 'Photos uploading' do
    let(:pic_path) { Rails.root.join('spec/fixtures/files/avatar.jpg') }
    let(:pic) { Rack::Test::UploadedFile.new(pic_path) }
    let(:user) { create(:user) }

    context 'with specified image' do
      it 'Image is uploaded' do
        image = create(:apartment_with_photos, user_id: user.id)
        expect(image).to be_valid
      end

      it 'image(Multiple)But uploaded' do
        image = create(:apartment_with_photos, photos: [pic, pic], user_id: user.id)
        expect(image).to be_valid
      end
    end
  end
end
