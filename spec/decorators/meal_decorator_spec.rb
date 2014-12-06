require 'rails_helper'

describe MealDecorator do
  let(:meal) { (create :meal).decorate }

  # describe "#bootrap_datetime_format" do
  #   it "formats the time correctly" do
  #     expect(meal.bootrap_datetime_format).to eq meal.start.strftime("%m/%d/%Y %l:%M %p")
  #   end
  # end

  describe "#short_start_date" do
    it "formats the date correctly" do
      expect(meal.short_start_date).to eq "#{meal.start.strftime("%a, %b")} #{meal.start.strftime("%-d").to_i.ordinalize}"
    end
  end
end
