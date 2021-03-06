require 'rails_helper'

describe SuppliesController do
  let(:user)    { create :user }
  let(:event)   { create :event, user: user }
  let(:supply1) { create :supply, event: event }
  let(:supply2) { create :supply, event: event }

  describe "GET index" do
    subject { get :index, event_id: event.id }

    it_behaves_like "an_unauthenticated_user" do
      let(:http_request) { post :create, event_id: "any" }
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

    it_behaves_like "an_unauthenticated_user" do
      let(:http_request) { get :index, event_id: "any" }
    end

    context "with a logged in user" do
      before :each do
        login_user user
      end
      context "with valid params" do
        let(:supply_params) { {name: "Paper Plates", cost: 10 } }

        it "creates a new supply record" do
          expect{subject}.to change{Supply.count}.by 1
        end

        it "redirects to the event_supplies_path" do
          subject
          expect(response).to redirect_to event_supplies_path
        end
      end

      context "with invalid params" do
        let(:supply_params) { {name: nil } }

        it "does not create a new supply record" do
          expect{subject}.not_to change{Supply.count}
        end

        it "rerenders the new template" do
          subject
          expect(response).to render_template :new
        end


      end
    end
  end

  describe "GET new" do
    subject { get :new, event_id: event.id }

    it_behaves_like "an_unauthenticated_user" do
      let(:http_request) { get :new, event_id: "any" }
    end

    context "with a logged in user" do
      before :each do
        login_user user
        subject
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "creates a blank Supply" do
        expect(assigns(:supply)).to be_a_new Supply
      end
    end
  end

  describe "GET edit" do
    it_behaves_like "an_unauthenticated_user" do
      let(:http_request) { patch :update, event_id: "Any", id: "Any" }
    end

    context "with a logged in user" do
      before :each do
        login_user user
      end

      context "when record is found in the database" do
        before  { get :edit, id: supply1.id, event_id: event.id }

        it "renders the :edit template" do
          expect(response).to render_template :edit
        end

        it "finds the correct object" do
          expect(assigns(:supply)).to eq supply1
        end
      end

      context "when when record is Not found in the database" do
        before { get :edit, id: "not an id", event_id: event.id }
        it "redirect to home" do
          expect(response).to redirect_to home_path
        end

        it "doesn't find any object" do
          expect(assigns(:supply)).to be nil
        end
      end
    end
  end

  describe "PATCH update" do
    subject { patch :update, event_id: event.id, id: supply1.id, supply: supply_params }

    it_behaves_like "an_unauthenticated_user" do
      let(:http_request) { patch :update, event_id: "Any", id: "Any" }
    end

    context "with a logged in user" do
      before :each do
        login_user user
      end

      context "with valid params" do
        let(:supply_params) { { purchased: true } }

        it "updates the supply item" do
          subject
          expect(supply1.reload.purchased?).to be true
        end
      end

      context "with invalid params" do
        let(:supply_params) { { name: nil } }

        it "does not update the supply item" do
          expect(supply1.reload.name).not_to be_nil
        end
      end
    end
  end

  describe "DELETE destroy"do
    it_behaves_like "an_unauthenticated_user" do
      let(:http_request) { delete :destroy, event_id: "Any", id: "Any" }
    end

    context "with a logged in user" do
      before { login_user user }

      context "when record is found in database" do
        it "deleted the record from the DB" do
          supply = create :supply, event: event
          expect{ delete :destroy, id: supply.id, event_id: event.id }.to change{ Supply.count }.by -1
        end

      end

      context "when record is not found in the database" do
        it "doesn't delete anything from the DB" do
          expect{ delete :destroy, id: "None", event_id: "None" }.not_to change{ Supply.count }
        end
      end
    end
  end
end
