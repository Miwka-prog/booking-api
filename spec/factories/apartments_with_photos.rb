FactoryBot.define do
  factory :apartment_with_photos, parent: :apartment do
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    country { Faker::Address.country }
    price_per_night { Faker::Commerce.price }
    photos do
      [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/photo1.jpg')),
       Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/photo3.jpg'))]
    end
  end
end
