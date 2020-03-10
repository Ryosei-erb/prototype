FactoryBot.define do
  factory :message do
    content { "content" }
    user
    room
  end
end
