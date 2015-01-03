require 'rails_helper'

describe SuppliesController do
  let(:user)    { create :user }
  let(:event)   { create :event, user: user }
  let(:supply1) { create :supply, event: event }
  let(:supply2) { create :supply, event: event }

  describe "GET index" do
    subject { get :index, event_id: event.id }

    it_behaves_like "an_unauthenticated_user" do
      let(:http_request) { get :index, event_id: "any" }
    end

    context "with a logged in user" do
      before :each do
        login_user user
        subject
      end

      it "renders the index template" do
        expect(response).to render_template :index
      end

      it "finds the correct event" do
        expect(assigns(:event)).to eq event
      end

      it "finds all supplies for the event" do
        expect(assigns(:supplies)).to match_array [supply1, supply2]
      end

      it "doesn't find supplies for other events" do
        supply3 = create :supply
        expect(assigns(:supplies)).not_to include supply3
      end
    end
  end

  describe "POST create" do
    subject { post :create, event_id: event.id, supply: supply_params }

    context "with a logged in user" do
      before :each do
        login_user user
      end
      context "with valid params" do
        let(:supply_params) { {name: "Paper Plates", cost: 10 } }

        it "creates a new supply record" do
          expect{subject}.to change{Supply.count}.by 1
        end
      end

      context "with invalid params" do
        let(:supply_params) { {name: nil } }

        it "does not create a new supply record" do
          expect{subject}.not_to change{Supply.count}
        end
      end
    end
  end
end
