require 'rails_helper'

describe CostsController do
  let(:user)  { create :user }
  let(:event) { create :event }

  describe "GET index" do
    subject { get :index, event_id: event.id }

    context "with a logged in user" do
      before :each do
        login_user user
        @meal   = create :meal, event: event, cost: 200
        @supply = create :supply, event: event, cost: 100
        subject
      end

      context "when event is found in the database" do
        context "when event has meals and supplies with costs" do
          it "renders the index template" do
            expect(response).to render_template :index
          end

          it "returns the correct total cost" do
            expect(assigns(:total_cost)).to eq 300
          end

          it "returns the all the meals or supplies with cos " do
            expect(assigns(:cost_items)). to match_array [@meal, @supply]
          end
        end
      end
    end
  end
end
