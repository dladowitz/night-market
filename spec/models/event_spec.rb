require "rails_helper"

describe Event do
  it { should validate_presence_of :name }
  it { should validate_presence_of :guests }

  it { should_not validate_presence_of :location }

  it "creates an Event object" do
    event = Event.new name: "Startup Weekend San Francisco"
    expect(event).to be_a Event
  end

  skip "has a valid factory" do
    event = create :event
    expect(event).to be_a Event
  end

  it "saves to the datebase" do
    expect { Event.create name: "Startup Weekend SF", guests: 100 }.to change{Event.count}.by 1
  end
end
