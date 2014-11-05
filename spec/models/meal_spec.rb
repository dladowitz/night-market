require 'rails_helper'

describe Meal do
  it { should validate_presence_of :category }

  it "creates a Meal object" do
    meal = Meal.create category: "Breakfast"
    expect(meal).to be_a Meal
  end

  it "has a valid factory" do
    meal = create :meal
    expect(meal).to be_a Meal
  end

  it "saves to the database" do
    expect{ Meal.create category: "Breakfast" }.to change{ Meal.count }.by 1
  end

  it "it validates category" do
    meal = Meal.new category: "Let's Cook"
    expect(meal.valid?).to be false
  end
end
