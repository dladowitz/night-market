# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :meal do
    association :event
    category "Breakfast"
    guests 100
    start 4.days.from_now
    ignore_warnings false
    cost 500
  end
end
