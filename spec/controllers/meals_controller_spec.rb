require 'rails_helper'

describe MealsController do
  let(:user)   { create :user }
  let(:event)  { create :event, user: user }
  let(:meal)   { event.meals.create category: "Lunch"}
  let(:meal2)  { event.meals.create category: "Dinner" }

  let(:user2)  { create :user }
  let(:event2) { create :event, user: user2 }
  let(:meal3)  { event2.meals.create category: "Dinner" }

  describe "GET index" do

    it_behaves_like "an_unauthenticated_user" do
      let(:http_request) { get :index, event_id: "any" }
    end

    context "with a logged in user" do
      before :each do
        login_user(user)
        subject
      end

      context "when looking at meal for an event the user owns" do
        subject { get :index, event_id: event.id }

        it "renders the index template" do
          expect(response).to render_template :index
        end

        it "finds the correct event" do
          expect(assigns(:event)).to eq event
        end

        it "finds all meals for the event" do
          expect(assigns(:meals)).to match_array [meal, meal2]
        end
      end

      context "when trying to see meals from other user's events" do
        subject { get :index, event_id: event2.id }

        it "doesn't find meals from events of other users" do
          expect(assigns(:meal)).to be_nil
        end

        it "redirects to the home page" do
          expect(response).to redirect_to home_path
        end
      end
    end
  end

  describe "GET event_select" do
    subject { get :event_select }

    # it_behaves_like "an_unauthenticated_user" do
    #   let(:event_id) { 1 }
    #   let(:http_request) { subject }
    # end

    context "with a logged in user" do
      before  :each do
        login_user(user)
        @event2 = create :event, user: user
        @event3 = create :event, user: user
        subject
      end

      it "renders the event_select template" do
        expect(response).to render_template :event_select
      end

      it "returns all events the user is authorized for" do
        expect(assigns(:events)).to match_array [@event2, @event3]
      end
    end

  end

  describe "GET new" do
    subject { get :new, event_id: event.id }

    it_behaves_like "an_unauthenticated_user" do
      let(:event_id) { 1 }
      let(:http_request) { subject }
    end

    context "with a logged in user" do
      before  :each do
        login_user(user)
        subject
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "creates a blank meal" do
        expect(assigns(:meal)).to be_a_new Meal
      end
    end
  end

  describe "GET show" do
    subject { get :show, event_id: event.id, id: meal.id }

    it_behaves_like "an_unauthenticated_user" do
      let(:http_request) { subject }
    end

    context "with a logged in user" do
      before :each do
        login_user(user)
        subject
      end

      it "renders the show template" do
        expect(response).to render_template :show
      end

      it "finds the correct meal" do
        expect(assigns(:meal)).to eq meal
      end

      #TODO add specs for meal not in database
    end
  end

  describe "POST create" do
    subject     { post :create, event_id: event.id, meal: meal_params }

    it_behaves_like "an_unauthenticated_user" do
      let(:meal_params) { { category: "Breakfast"} }
      let(:http_request) { subject }
    end

    context "with a logged in user" do
      before { login_user(user) }

      context "with valid params" do
        let(:meal_params) { { category: "Breakfast"} }

        it "creates a new meal in the database" do
          expect{ subject }.to change{ Meal.count }.by 1
        end
      end

      context "with invalid params" do
        context "without required attributes" do
          let(:meal_params) { { category: nil }}

          it "does not create a meal in the database" do
            expect{ subject }.to_not change{ Meal.count }
          end

          it "re-renders the new template" do
            subject
            expect(response).to render_template :new
          end
        end

        context "with bad data types" do
          let(:meal_params) { { category: "Breakfast", guests: "Not a number" } }

          it "does not create a meal in the database" do
            expect{ subject }.to_not change{ Meal.count }
          end
        end

        context "with an invalid category" do
          let(:meal_params) { { category: "Bad Category" } }

          it "does not create a meal in the database" do
            expect{ subject }.to_not change{ Meal.count }
          end
        end
      end
    end
  end

  describe "GET edit" do
    subject { get :edit, event_id: event.id, id: meal_id }

    it_behaves_like "an_unauthenticated_user" do
      let(:meal_id) { 1 }
      let(:http_request) { subject }
    end

    context "with a logged in user" do
      before  :each do
        login_user(user)
        subject
      end

      context "when meal is in the database" do
        let(:meal_id) { meal.id }

        it "renders the edit template" do
          expect(response).to render_template :edit
        end

        it "finds the correct meal" do
          expect(assigns(:meal)).to eq meal
        end
      end

      context "when meal is not in the database" do
        let(:meal_id) { "Not a real ID"}

        it "meal is nil" do
          expect(assigns(:meal)).to be_nil
        end

        it "redirects to the home page" do
          expect(response).to redirect_to home_path
        end
      end
    end
  end

  describe "PATCH update" do
    subject { patch :update, event_id: event.id, id: meal_id, meal: params }

    it_behaves_like "an_unauthenticated_user" do
      let(:params)  { { category: "Snack" } }
      let(:meal_id) { "any" }
      let(:http_request) { subject }
    end

    context "with a logged in user" do
      before  :each do
        login_user(user)
        subject
      end

      context "with a meal in the database" do
        let(:meal_id) { meal.id }

        context "with valid params" do
          let(:params)  { { category: "Snack" } }

          it "updates the meal" do
            expect(meal.reload.category).to eq "Snack"
          end
        end

        context "with invalid params" do
          let(:params)  { { category: "Hammer Time" } }

          it "does not update the meal" do
            expect(meal.reload.category).to eq "Lunch"
          end
        end
      end

      context "with a meal not in the database" do
        let(:params)  { { category: "Snack" } }
        let(:meal_id) { "Not a real ID" }

        it "does not find the meal" do
          expect(assigns(:meal)).to be_nil
        end
      end
    end
  end

  describe "DELETE Destroy" do
    let!(:meal4) { create :meal, event: event4 }
    let!(:event4) { create :event, user: user }
    subject { delete :destroy, event_id: event4.id, id: meal4_id }

    it_behaves_like "an_unauthenticated_user" do
      let(:meal4_id) { "any" }
      let(:http_request) { subject }
    end

    context "with a logged in user" do
      before { login_user(user) }

      context "when meal is found in the database" do
        let(:meal4_id) { meal4.id }

        it "finds the correct meal" do
          subject
          expect(assigns(:meal)).to eq meal4
        end

        it "deletes the meal from the database" do
          expect{ subject }.to change{ Meal.count}.by -1
        end

        it "redirects to the event_meals index page" do
          subject
          expect(response).to redirect_to event_meals_path(event4)
        end
      end

      context "when meal is not found in the database" do
        let(:meal4_id) { "Not a real ID" }

        it "doesn't find a meal" do
          subject
          expect(assigns(:meal)).to be_nil
        end

        it "doesn't delete anything from the database" do
          expect{ subject }.to_not change{ Meal.count }
        end

        it "redirects to the home page" do
          subject
          expect(response).to redirect_to home_path
        end
      end
    end
  end
end
