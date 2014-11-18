require "rails_helper"

describe Event do
  it { should validate_presence_of     :name }
  it { should validate_presence_of     :user_id}
  it { should validate_numericality_of :user_id}
  it { should validate_presence_of     :guests }
  it { should validate_numericality_of :guests }
  it { should_not validate_presence_of :location }

  it { should have_many :meals }

  it "creates an Event object" do
    event = Event.new name: "Startup Weekend San Francisco", guests: 100, start_date: 1.day.from_now, end_date: 3.days.from_now
    expect(event).to be_a Event
  end

  it "has a valid factory" do
    event = create :event
    expect(event).to be_a Event
  end

  it "saves to the datebase" do
    user = create :user
    expect { user.events.create name: "Startup Weekend SF", guests: 100, start_date: 1.day.from_now, end_date: 3.days.from_now }.to change{Event.count}.by 1
  end

  describe "#overbudget?" do
    let(:event) { create :event }

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
    let(:event) { create :event }

    it "returns the total spending for all aspects of the event" do
      #TODO should add up dishes and supplies. Need to implement.
      expect(event.current_spend).to eq event.budget + 100 #Placeholder just so the method returns something
    end
  end
end
