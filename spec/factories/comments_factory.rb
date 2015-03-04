FactoryGirl.define do
  factory :comment do
    body Faker::Lorem.sentence
    author Faker::Name.name
    post
  end
end
