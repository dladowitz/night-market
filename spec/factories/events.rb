FactoryGirl.define do
  factory :event do
    association :user
    name "Startup Weekend San Francisco"
    guests 99
    start_date 3.days.from_now
    end_date   5.days.from_now
  end
end
