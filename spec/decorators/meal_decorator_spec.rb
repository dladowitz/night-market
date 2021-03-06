require 'rails_helper'

describe MealDecorator do
  let(:meal) { (create :meal).decorate }

  # describe "#bootstrap_datetime_format" do
  #   it "formats the time correctly" do
  #     expect(meal.bootrap_datetime_format).to eq meal.start.strftime("%m/%d/%Y %l:%M %p")
  #   end
  # end

  describe "#short_start_date" do
    it "formats the date correctly" do
      expect(meal.short_start_date).to eq "#{meal.start.strftime("%a, %b")} #{meal.start.strftime("%-d").to_i.ordinalize}"
    end
  end

  describe "#percentage_of_budget" do
    let(:event) { create :event, budget: 5000 }

    subject { meal.percentage_of_budget }

    context "when percent_of_budget is present" do
      let(:meal)  { (event.meals.create cost: 1000).decorate }

      it "formats the cost of the meal percentage correctly" do
        expect(subject).to eq "20% of event budget"
      end
    end

    context "when percent_of_budget is nil" do
      let(:meal)  { (event.meals.create cost: nil).decorate }

      it "returns a message" do
        expect(subject).to eq "Missing Meal Cost or Event Budget"
      end
    end
  end
end
