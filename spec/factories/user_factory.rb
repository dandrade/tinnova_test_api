  FactoryBot.define do

  factory :user do
    email { Faker::Internet.unique.email }
    name { Faker::Name.first_name }
    sequence(:username) { |n| "user#{n}" }
    last_name { Faker::Name.last_name }
    password {'123456'}
  end
end