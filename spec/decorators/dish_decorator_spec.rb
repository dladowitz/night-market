require 'rails_helper'

describe DishDecorator do

  describe "#show_warning?" do
    subject    { dish.decorate.show_warning?(:transport)}
    let(:meal) { create :meal}

    context "when meal.ignore_warnings returns false" do
      before { meal.update(ignore_warnings: false) }

      context "when transport_warning? returns true" do
        let(:dish) {create :dish, meal: meal, transport_method: "Delivery", transport_time: nil }

        it "returns true" do
          expect(subject).to be true
        end
      end

      context "when transport_warning? returns false" do
        let(:dish) {create :dish, meal: meal, transport_method: "Delivery", transport_time: DateTime.now }

        it "returns false" do
          expect(subject).to be false
        end
      end
    end

    context "when meal.ignore_warnings returns true" do
      before { meal.update(ignore_warnings: true) }

      context "when transport_warning? returns true" do
        let(:dish) {create :dish, meal: meal, transport_method: "Delivery", transport_time: nil }

        it "returns false" do
          expect(subject).to be false
        end
      end
    end

    context "with an invalid warning_type" do
      subject { dish.decorate.show_warning?(:bad_warning_type)}
      let(:dish) {create :dish, meal: meal, transport_method: "Delivery", transport_time: nil }

      it "raises and exception" do
        expect { subject }.to raise_error
      end
    end
  end
end
