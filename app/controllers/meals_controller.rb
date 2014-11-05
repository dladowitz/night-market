class MealsController < ApplicationController
  before_filter :load_event

  def index
    @meals = @event.meals
  end

  def new
    @meal = Meal.new
  end

  def show
    @meal = Meal.find params[:id]
  end

  private
  def load_event
    @event = Event.find params[:event_id]
  end
end
