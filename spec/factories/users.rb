# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name      "Walter"
    last_name       "White"
    email_address   { Faker::Internet.email }
    password_digest "asdfasdf"
    admin false
  end
end
