require 'rails_helper'

describe MealDecorator do
  let(:meal) { create :meal }

  describe "#bootrap_datetime_format" do
    it "formats the time correctly" do
      expect(meal.decorate.bootrap_datetime_format).to eq meal.start.strftime("%m/%d/%Y %l:%M %p")
    end
  end
end
