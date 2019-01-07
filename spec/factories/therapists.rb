FactoryBot.define do
  factory :therapist do
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end
end
