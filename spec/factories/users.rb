FactoryBot.define do
  factory :user do
    name { "Name" }
    sequence(:email) { |n| "whatever#{n}@whatever.com" }
    salt { "salt" }
    crypted_password { "crypted" }
    password { "password" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/53ma03.jpg')) }
  end
end
