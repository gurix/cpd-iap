FactoryBot.define do
  factory :client do
    identifier { (0..100).to_a.sample(3).join('-') }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
