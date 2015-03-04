FactoryGirl.define do
  factory :post do
    title Faker::Lorem.sentence
    body Faker::Lorem.paragraphs(3)
    author Faker::Name.name
  end
end
