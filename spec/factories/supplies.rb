# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :supply do
    association :event
    name "Paper Plates"
    purchased false
    vendor "Costco"
  end
end
