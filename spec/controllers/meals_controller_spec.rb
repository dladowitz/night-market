require 'rails_helper'

describe MealsController do
  let(:meal)  { create :meal}
  let(:meal2) { event.meals.create category: "Dinner" }
  let(:event) { meal.event }

  describe "GET index" do
    subject { get :index, event_id: event.id }
    before { subject }

    it "renders the index template" do
      expect(response).to render_template :index
    end

    it "finds the correct event" do
      expect(assigns(:event)).to eq event
    end

    it "finds all meals for the event" do  #TODO make this a it_behaves_like for all methods
      expect(assigns(:meals)).to match_array [meal, meal2]
    end
  end

  describe "GET new" do
    subject { get :new, event_id: event.id }
    before  { subject }

    it "renders the new template" do
      expect(response).to render_template :new
    end

    it "creates a blank meal" do
      expect(assigns(:meal)).to be_a_new Meal
    end
  end

  describe "GET show" do
    subject { get :show, event_id: event.id, id: meal.id }
    before { subject }

    it "renders the show template" do
      expect(response).to render_template :show
    end

    it "finds the correct meal" do
      expect(assigns(:meal)).to eq meal
    end

    #TODO add specs for meal not in database
  end

  describe "POST create" do
    let(:event) { create :event }
    subject     { post :create, event_id: event.id, meal: meal_params }

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

  describe "GET edit" do
    subject { get :edit, event_id: event.id, id: meal_id }
    before  { subject }

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

      it "redirects to the event_meals index page" do
        expect(response).to redirect_to event_meals_path(event)
      end
    end
  end

  describe "PATCH update" do
    subject { patch :update, event_id: event.id, id: meal_id, meal: params }
    before  { subject }

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
          expect(meal.reload.category).to eq "Breakfast"
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

  describe "DELETE Destroy" do
    let!(:meal_3) { create :meal }
    let!(:event_3) { meal_3.event }
    subject { delete :destroy, event_id: event_3.id, id: meal_3_id }

    context "when meal is found in the database" do
      let(:meal_3_id) { meal_3.id }

      it "finds the correct meal" do
        subject
        expect(assigns(:meal)).to eq meal_3
      end

      it "deletes the meal from the database" do
        expect{ subject }.to change{ Meal.count}.by -1
      end

      it "redirects to the event_meals index page" do
        subject
        expect(response).to redirect_to event_meals_path(event_3)
      end
    end

    context "when meal is not found in the database" do
      let(:meal_3_id) { "Not a real ID" }

      it "doesn't find a meal" do
        subject
        expect(assigns(:meal)).to be_nil
      end

      it "doesn't delete anything from the database" do
        expect{ subject }.to_not change{ Meal.count }
      end

      it "redirects to the event_meals page" do
        subject
        expect(response).to redirect_to event_meals_path(event_3)
      end
    end
  end
end
