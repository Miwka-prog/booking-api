FactoryBot.define do
  factory :comment do
    association :user, factory: :user
    association :apartment, factory: :apartment
    content { Faker::TvShows::FinalSpace.quote }
  end
end
