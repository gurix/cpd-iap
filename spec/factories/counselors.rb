FactoryBot.define do
  factory :counselor do
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end
end
