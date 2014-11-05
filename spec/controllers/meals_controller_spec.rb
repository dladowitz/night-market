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
  end

  describe "POST create" do
    subject { post :create, event_id: event.id, meal: params }

    context "with valid params" do
      let(:params) { { category: "Breakfast"} }

      it "creates a new meal in the database" do
        expect{ subject }.to change{ Meal.count }.by 1
      end
    end

    context "with invalid params" do
      context "without required attributes" do
        let(:params) { { category: nil }}

        it "does not create a meal in the database" do
          expect{ subject }.to_not change{ Meal.count }
        end
      end

      context "with bad data types" do
        let(:params) { { category: "Breakfast", guests: "Not a number" } }

        it "does not create a meal in the database" do
          expect{ subject }.to_not change{ Meal.count }
        end
      end

      context "with an invalid category" do
        let(:params) { { category: "Bad Category" } }

        it "does not create a meal in the database" do
          expect{ subject }.to_not change{ Meal.count }
        end
      end
    end
  end
end
