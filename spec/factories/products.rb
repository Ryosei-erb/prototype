FactoryBot.define do
  factory :product do
    name { "Melon bakery" }
    description { "Taste Good !" }
    pickup_times { "till pm 19:00" }
    price { 440 }
    user
  end
end
