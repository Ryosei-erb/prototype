FactoryBot.define do
  factory :product do
    name { "Melon bakery" }
    description { "Taste Good !" }
    pickup_times { "till pm 19:00" }
    price { 440 }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/53ma03.jpg')) }
    user
    trait :invalid do
      name { nil }
    end
  end
end
