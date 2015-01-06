require 'rails_helper'

describe CostsController do
  let(:user)  { create :user }
  let(:event) { create :event }

  describe "GET index" do
    subject { get :index, event_id: event.id }

    context "with a logged in user" do
      before :each do
        login_user user
      end

      context "when event is found in the database" do
        context "when event has meals and supplies with costs" do
          it "renders the index template" do
            @meal1 = create :meal, event: event, cost: 200
            get :index, event_id: event.id

            expect(response).to render_template :index
          end

          it "returns the correct total cost" do

            @meal1 = create :meal, event: event, cost: 200
            get :index, event_id: event.id

            expect(assigns(:total_cost)).to eq 500
          end

          it "returns the all the meals or supplies with costs" do
            @meal1 = create :meal, event: event, cost: 200

            get :index, event_id: event.id

            expect(assigns(:cost_items)). to match_array [@meal]
          end
        end
      end
    end
  end
end
