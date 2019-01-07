FactoryBot.define do
  factory :client do
    identifier { (0..100).to_a.sample(3).join('-') }
    name { Faker::Name.name }
    class_of_age { %w[child adult].sample }
  end
end
