require 'rails_helper'

describe Supply do
  it { should validate_presence_of :name }
  it { should validate_presence_of :event_id }

  it "should have a valid factory" do
    expect(create :supply).to be_an_instance_of Supply
  end
end

