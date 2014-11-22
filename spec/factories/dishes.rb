# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dish do
    association :meal
    name        "Cheese Pizza"
    vendor      "Patxi's Pizza"
    servings    50
    category    "Main"
    ordered     false
    vegetarian  true
    vegan       false
    gluten_free false
    needs_ice   false
    transport_method "Pickup"
    transport_time 4.days.from_now
  end
end
