require "rails_helper"

describe Event do
  it { should validate_presence_of :name }


  it "creates an Event object" do
    event = Event.new name: "Startup Weekend San Francisco"
    expect(event).to be_a Event
  end
end
