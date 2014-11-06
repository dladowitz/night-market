require 'rails_helper'

describe Dish do
  it { should validate_presence_of     :name     }
  it { should validate_numericality_of :servings }
  it { should validate_presence_of     :category }
  it { should validate_presence_of     :meal_id  }
  it { should validate_numericality_of :meal_id  }

  it { should belong_to :meal }

  it "creates a Dish object" do
    meal = create :meal
    dish = meal.dishes.create name: "BBQ Sandwiches", category: "Main"

    expect(dish).to be_a Dish
    expect(dish).to be_valid
  end

  it "has a valid factory" do
    dish = create :dish
    expect(dish).to be_valid
  end

  it "saves an object to the database" do
    expect{ create :dish }.to change{ Dish.count }.by 1
  end

  it "validates category" do
    dish = Dish.new category: "Bad Category", meal_id: 1, name: "Pizza"
    expect(dish).to_not be_valid
  end

  it "validates transport_method" do
    dish = Dish.new transport_method: "Carrier Pigeon", name: "BBQ Sandwiches", category: "Main", meal_id: 1
    expect(dish).to_not be_valid
  end
end



# default format
# RSpec.describe Dish, :type => :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
