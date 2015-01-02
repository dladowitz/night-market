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

  describe "#dish_warnings?" do
    subject { meal.dish_warnings? }

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
    context "when the event requires gluten-free options" do
      before { meal.event.update gluten_free: true }

      context "when no dishes in the meal are gluten-free" do
        let(:warning_type) { :gluten_free}
        before { dish.update gluten_free: false }

        context "when ignore_warnings returns true" do
          before { meal.update ignore_warnings: true }

          it "returns true" do
            expect(meal.show_warning?(:gluten_free)).to be false
          end
        end

        context "when ignore_warnings returns false" do
          before { meal.update ignore_warnings: false }

          it "returns true" do
            expect(meal.show_warning?(:gluten_free)).to be true
          end
        end
      end
    end

    context "when the event does not require gluten-free options" do
      before { meal.event.update gluten_free: false }

      context "when no dishes in the meal are gluten-free" do
        let(:warning_type) { :gluten_free}
        before { dish.update gluten_free: false }

        it "returns true" do
          expect(meal.show_warning?(:gluten_free)).to be false
        end
      end
    end

    context "when a dish in the meal has warnings" do
      context "when 'ignore_warnings' is false" do
        it "returns true" do
          allow_any_instance_of(Dish).to receive(:has_warnings?).and_return(true)
          expect(meal.show_warning?).to be true
        end
      end

      context "when 'ignore_warnings' is true" do
        before { meal.update ignore_warnings: true }

        it "returns false" do
          allow_any_instance_of(Dish).to receive(:has_warnings?).and_return(true)
          expect(meal.show_warning?).to be false
        end
      end
    end
  end

  describe "#warning_messages" do
    subject { meal.warning_messages }

    context "when there are dish warnings" do
      before { dish.update transport_method: "Delivery", transport_time: nil }

      it "has correct warnings" do
        expect(subject).to eq [{warning_type: dish.name, message: "No Delivery Time Set"}]
      end
    end

    context "when there are option warnings" do
      before { meal.event.update gluten_free: true }

      it "has correct warnings" do
        expect(subject).to eq [{warning_type: "Gluten-Free", message: "Missing Option"}]
      end
    end
  end

  describe "#percent_of_total" do
    let(:event) { create :event, budget: 5000 }
    subject { meal.percent_of_budget }

    context "with Meal cost and Event Budget" do
      let(:meal)  { event.meals.create cost:1000 }

      it "returns the correct percentage" do
        expect(subject).to eq 20
      end
    end

    context "when meal cost is missing" do
      let(:meal)  { event.meals.create cost: nil }

      it "returns an error message" do
        expect(subject).to be nil
      end
    end
  end

  describe "#dishes_include_option?" do
    subject { meal.dishes_include_option? :gluten_free }


    context "when the meal has a gluten-free dish" do
      before { dish.update gluten_free: true }

      it "returns true" do
        expect(subject).to be true
      end
    end

    context "when the meal does NOT havve a gluten-free dish" do
      before { dish.update gluten_free: false }

      it "returns false" do
        expect(subject).to be false
      end
    end


  end
end
