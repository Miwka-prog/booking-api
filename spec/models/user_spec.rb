# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  birth_date             :date
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  gender                 :integer          default(0), not null
#  last_name              :string
#  mobile                 :string           default("")
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Model validations' do
    it 'ensures password optional' do
      user = described_class.new(email: 'test@mail.test', first_name: "Name", last_name: "Last").save
      expect(user).to eq(false)
    end
    it 'wiht validation optional' do
      user = described_class.new(email: 'test@mail.test', first_name: "Name", last_name: "Last",
                                 password: "123214", birth_date: Date.new(2002, 01, 01)
                                 ).save
      expect(user).to eq(true)
    end
    it 'ensures email validator works' do
      user = described_class.new(email: '@mail.test', first_name: "Name", last_name: "Last",
                                 password: "123214", birth_date: Date.new(2002, 01, 01)
      ).save
      expect(user).to eq(false)
    end
    it 'ensures birth date validator works' do
      user = described_class.new(email: 'mail@mail.test', first_name: "Name", last_name: "Last",
                                 password: "123214", birth_date: Date.new(2005, 01, 01)
      ).save
      expect(user).to eq(false)
    end
    it 'ensures first and second name validator works' do
      user = described_class.new(email: 'mail@mail.test',
                                 password: "123214", birth_date: Date.new(2005, 01, 01)
      ).save
      expect(user).to eq(false)
    end
  end
end
