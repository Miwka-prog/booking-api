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
#  gender                 :integer          default("unknown"), not null
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
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Allowlist

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :allowlisted_jwts, dependent: :destroy

  validates :first_name, :last_name, presence: true

  enum gender: { unknown: 0, male: 1, female: 2 }

  validates :gender, inclusion: { in: User.genders.keys }

  validates :birth_date, presence: true
  validate :validate_age

  def for_display
    {
      email: email,
      id: id
    }
  end

  private

  def validate_age
    errors.add(:birth_date, 'You should be over 18 years old.') if birth_date.present? && birth_date > 18.years.ago
  end
end
