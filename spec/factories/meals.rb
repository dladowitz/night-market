# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :meal do
    association :event
    category "Breakfast"
    guests 100
    start 4.days.from_now
  end
end
