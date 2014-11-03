require 'rails_helper'

describe EventsController do
  describe "GET index" do
    subject { get :index }

    let!(:event1) { Event.create name: "SW SF", guests: 100, start_date: 6.days.from_now, end_date: 8.days.from_now }
    let!(:event2) { Event.create name: "SW SF", guests: 100, start_date: 3.days.from_now, end_date: 5.days.from_now }

    before { subject }

    it "renders the index template" do
      expect(response).to render_template :index
    end

    it "finds all events" do
      binding.pry
      binding.pry
      binding.pry

      expect(assigns(:events).count).to eq 2
    end

    it "shows them chronological order by start date" do

      def test
        p "this is a test"
      end

    end
  end
end
