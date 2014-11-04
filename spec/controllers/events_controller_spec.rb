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

  describe "POST create" do
    subject { post :create, event: params }

    context "with valid params" do
      let(:params ){ { name: "Startup Weekend Oakland", guests: 55, start_date: 3.days.from_now, end_date: 5.days.from_now } }

      it "should create a new object in the database" do
        expect { subject }.to change{Event.count}.by 1
      end
    end

    context "with invalid params" do

      context "without required params" do
        let(:params ) { { name: "Startup Weekend Oakland" } }

        it "does not create a new object in the database" do
          expect { subject }.to_not change{Event.count}
        end
      end

      context "with bad data types" do

        context "when guests is not a number" do
          let(:params) { { name: "Startup Weekend Oakland", guests: "Many" } }

          it "does not create a new object in the database" do
            expect { subject }.to_not change{Event.count}
          end
        end

        context "when start_date is not a date" do
          let(:params) { { name: "Startup Weekend Oakland", guests: 100, start_date: "Sometime" } }

          it "does not create a new object in the database" do
            expect { subject }.to_not change{Event.count}
          end
        end
      end
    end
  end
end
