FactoryBot.define do
  factory :message do
    association :conversation, factory: :conversation
    association :user, factory: :user
    content { Faker::TvShows::FinalSpace.quote }
  end
end
