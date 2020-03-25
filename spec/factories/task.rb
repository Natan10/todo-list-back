FactoryBot.define do
  factory :task do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    status { [true,false].sample() }
    priority { [:urgente,:moderado,:relaxado].sample() }

    user
  end
end