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

  describe "#has_warnings?" do
    subject { dish.has_warnings? }

    context "when the dish has warnings" do
      let(:dish) { create :dish, needs_ordering: true, ordered: false }
      it "returns true" do
        expect(subject).to be true
      end
    end

    context "when the dish doesn't have warnings" do
      let(:dish) { create :dish }
      it "returns false" do
        expect(subject).to be false
      end
    end
  end

  describe "#order_status" do
    subject { dish.order_status }

    context "dish needs to be ordered ahead of time" do
      context "dish has been ordered" do
        let(:dish) { create :dish, needs_ordering: true, ordered: true}

        it "returns 'Already Ordered'" do
          expect(subject).to eq "Already Ordered"
        end
      end

      context "dish has not been ordered" do
        let(:dish) { create :dish, needs_ordering: true, ordered: false}

        it "returns 'Needs to be Ordered'" do
          expect(subject).to eq "Needs to be Ordered"
        end
      end
    end

    context "dish does not needs to be ordered ahead of time" do
      let(:dish) { create :dish, needs_ordering: false, ordered: nil}

      it "returns 'Doesn't Require Ordering" do
        expect(subject).to eq "Doesn't Require Ordering"
      end
    end
  end

  describe "#order_warning" do
    subject { dish.order_warning? }

    context "dish needs to be ordered ahead of time" do
      context "dish has been ordered" do
        let(:dish) { create :dish, needs_ordering: true, ordered: true}

        it "returns false" do
          expect(subject).to be false
        end
      end

      context "dish has not been ordered" do
        let(:dish) { create :dish, needs_ordering: true, ordered: false}

        it "returns true" do
          expect(subject).to be true
        end
      end
    end

    context "dish does not needs to be ordered ahead of time" do
      let(:dish) { create :dish, needs_ordering: false, ordered: nil}

      it "returns false" do
        expect(subject).to be false
      end
    end
  end

  describe "#transport_warning" do
    subject { dish.transport_warning? }

    context "Delivery" do
      context "when delivery time is set" do
        let(:dish) { create :dish, transport_method: "Delivery", transport_time: DateTime.now}

        it "returns false" do
          expect(subject).to be false
        end
      end

      context "when delivery time is not set" do
        let(:dish) { create :dish, transport_method: "Delivery", transport_time: nil }

        it "retuns true" do
          expect(subject).to be true
        end
      end
    end

    context "Pickup" do
      let(:dish) { create :dish, transport_method: "Pickup" }

      it "returns false" do
        expect(subject).to be false
      end
    end
  end

  describe "#servings_warning" do
    subject { dish1.servings_warning? }
    let(:meal)  { create :meal }

    context "when servings don't equal guest count" do
      let!(:dish1) { create :dish, meal: meal, category: "Main", servings: 0 }
      let!(:dish2) { create :dish, meal: meal, category: "Main", servings: 0 }

      it "returns true" do
        expect(subject).to be true
      end
    end

    context "when servings equal guest count" do
      let!(:dish1) { create :dish, meal: meal, category: "Main", servings: meal.guests/2 }
      let!(:dish2) { create :dish, meal: meal, category: "Main", servings: meal.guests/2 }

      it "returns false" do
        expect(subject).to be false
      end
    end
  end

  describe "#warning_messages" do
    skip "it works" do

    end
  end
end
