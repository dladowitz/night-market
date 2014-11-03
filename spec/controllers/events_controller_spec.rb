require 'rails_helper'

describe EventsController do
  describe "GET index" do
    subject { get :index }

    let!(:event1) { create :event }
    let!(:event2) { create :event }

    before { subject }

    it "renders the index template" do
      expect(response).to render_template :index
    end

    it "finds all events" do
      expect(assigns(:events)).to match_array [event1, event2]
    end

    skip "shows them chronological order by start date" do
      # not sure how to check order of elements in an array
    end
  end

  describe "GET new" do
    subject { get :new }

    before { subject }

    it "renders the new template" do
      expect(response).to render_template :new
    end

    it "creates a blank event" do
      expect(assigns(:event)).to be_a Event
    end
  end
end
