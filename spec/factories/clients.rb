FactoryBot.define do
  factory :client do
    identifier { (0..100).to_a.sample(3).join('-') }
    name { Faker::Name.name }
  end
end
