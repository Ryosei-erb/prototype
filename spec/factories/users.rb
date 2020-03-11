FactoryBot.define do
  factory :user do
    name { "Name" }
    sequence(:email) { |n| "e#{n}@e.com" }
    salt { "asdasdastr4325234324sdfds" }
    crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt("secret", salt) }
    password { "secret" }
    password_confirmation { "secret" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/53ma03.jpg')) }
  end
end
