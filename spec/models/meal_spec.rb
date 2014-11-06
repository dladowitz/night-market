require 'rails_helper'

describe Meal do
  it { should validate_presence_of :category }
  it { should validate_presence_of :event_id }
  it { should validate_numericality_of :event_id }

  it { should belong_to :event }
  it { should have_many :dishes }

  it "creates a Meal object" do
    event = create :event
    meal = event.meals.create category: "Breakfast"
    expect(meal).to be_a Meal
    expect(meal).to be_valid
  end

  it "has a valid factory" do
    meal = create :meal
    expect(meal).to be_a Meal
  end

  it "saves to the database" do
    expect{ create :meal }.to change{ Meal.count }.by 1
  end

  it "it validates category" do
    meal = Meal.new category: "Let's Cook"
    expect(meal.valid?).to be false
  end

  it "validates category" do
    meal = Meal.new category: "Bad Category", event_id: 1
    expect(meal).to_not be_valid
  end
end
