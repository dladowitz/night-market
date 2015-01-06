require "rails_helper"

describe Event do
  it { should validate_presence_of     :name }
  it { should validate_presence_of     :user_id}
  it { should validate_numericality_of :user_id}
  it { should validate_presence_of     :guests }
  it { should validate_numericality_of :guests }
  it { should_not validate_presence_of :location }

  it { should have_many :meals }

  let(:event) { create :event }
  let(:user)  { create :user }

  it "creates an Event object" do
    event = Event.new name: "Startup Weekend San Francisco", guests: 100, start_date: 1.day.from_now, end_date: 3.days.from_now
    expect(event).to be_a Event
  end

  it "has a valid factory" do
    expect(event).to be_a Event
  end

  it "saves to the datebase" do
    expect { user.events.create name: "Startup Weekend SF", guests: 100, start_date: 1.day.from_now, end_date: 3.days.from_now }.to change{Event.count}.by 1
  end

  describe "#overbudget?" do
    context "when the event is over budget" do
      it "returns true" do
        allow(event).to receive(:current_spend).and_return(event.budget + 100)
        expect(event.overbudget?).to be true
      end
    end

    context "when the event it on or under budget" do
      it "returns false" do
        allow(event).to receive(:current_spend).and_return(event.budget - 100)
        expect(event.overbudget?).to be false
      end
    end
  end

  describe "#current_spend" do
    before do
      event.meals.create cost: 2000
      event.meals.create cost: 1000
    end

    it "returns the total spending for all aspects of the event" do
      expect(event.current_spend).to eq 3000
    end
  end

  describe "#show_warnings?" do
    subject { event.show_warnings? }

    let!(:meal) { create :meal }
    let(:event) { meal.event }

    context "with a meal that has warnings" do
      it "returns true" do
        allow_any_instance_of(Meal).to receive(:ignore_warnings).and_return(false)
        allow_any_instance_of(Meal).to receive(:warning_messages).and_return(["warnings_present"])
        expect(subject).to be true
      end
    end

    context "without a meal that has warnings" do
      it "returns false" do
        allow_any_instance_of(Meal).to receive(:ignore_warnings).and_return(false)
        allow_any_instance_of(Meal).to receive(:warning_messages).and_return([])
        expect(subject).to be false
      end
    end
  end

  describe "#missing_supplies" do
    subject { event.missing_supplies }

    context "when event has supplies that have not been purchased" do
      it "returns an array of missing supplies" do
        supply1 = create :supply, event_id: event.id
        expect(subject).to match_array supply1
      end
    end

    context "when all supplies for an event have been purchased" do
      it "returns and empty array" do
        create :supply, event_id: event.id, purchased: true
        expect(subject).to match_array []
      end
    end
  end

  describe "#get_cost_items" do
    subject { event.get_cost_items }

    context "when event has meals and supplies with costs" do
      before :each do
        @supply1 = create :supply, event: event, cost: 100
        @meal1   = create :meal,   event: event, cost: 200
      end

      it "returns an array of items with cost" do
        expect(subject).to match_array [@supply1, @meal1]
      end
    end

    context "when event does not have meals or supplies with costs" do
      it "returns an empty array" do
        expect(subject).to match_array []
      end
    end
  end
end
