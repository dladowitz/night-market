require 'rails_helper'

describe Meal do
  it { should validate_presence_of :category }
  it { should validate_presence_of :event_id }
  it { should validate_numericality_of :event_id }

  it { should belong_to :event }
  it { should have_many :dishes }

  let(:dish) { create :dish }
  let(:meal) { dish.meal }

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

  describe "#has_warnings?" do
    subject { meal.has_warnings? }

    context "when dishes have warnings" do
      it "raises warnings on the meal" do
        allow_any_instance_of(Dish).to receive(:has_warnings?).and_return(true)
        expect(subject).to be true
      end
    end

    context "when dishes don't have warnings" do
      it "doesn't have warnings on the meal" do
        allow_any_instance_of(Dish).to receive(:has_warnings?).and_return(false)
        expect(subject).to be false
      end
    end
  end

  describe "#show_warning?" do
    subject { meal.show_warning? }

    context "when a dish has warnings" do
      context "when 'ignore_warnings' is true" do
        before { meal.update ignore_warnings: true }

        it "returns false" do
          allow_any_instance_of(Dish).to receive(:has_warnings?).and_return(true)
          expect(subject).to be false
        end
      end

      context "when 'ignore_warnings' is false" do
        it "returns true" do
          allow_any_instance_of(Dish).to receive(:has_warnings?).and_return(true)
          expect(subject).to be true
        end
      end
    end
  end
end
