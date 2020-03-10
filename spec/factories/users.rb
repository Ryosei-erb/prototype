FactoryBot.define do
  factory :user do
    name { "Name" }
    sequence(:email) { |n| "whatever#{n}@whatever.com" }
    salt { "salt" }
    crypted_password { "crypted" }
    password { "password" }
    image { "image" }
    # after(:product) do |user|
    #   build(:product, user: user)
    # end
  end
end
