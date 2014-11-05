class MealsController < ApplicationController
  before_filter :load_event
  before_filter :load_meal, only: [:show, :edit, :update]

  def index
    @meals = @event.meals
  end

  def new
    @meal = Meal.new
  end

  def show
    @meal = Meal.find params[:id]
  end

  def create
    @meal = @event.meals.build meal_params

    if @meal.save
      flash[:success] = "Hi Five. Meal created successfully."
      redirect_to event_meal_path(@event, @meal)
    else
      #TODO probably need to re-render the form and surface errors
      flash[:danger] = "Slow your roll partna. Meal wasn't created properly"
      redirect_to event_meals_path(@event)
    end
  end

  def edit

  end

  def update
    if @meal.update meal_params
      redirect_to event_meal_path(@event, @meal)
    else
      flash[:danger] = "Oh Frak, that didn't work."
      render :edit
    end
  end

  private

  def load_event
    @event = Event.find params[:event_id]
  end

  def load_meal
    @meal = Meal.find_by_id params[:id]

    unless @meal
      flash[:danger] = "Easy friend. That's not a meal I've ever heard of."
      redirect_to event_meals_path(@event)
    end
  end

  def meal_params
    params.require(:meal).permit(:category, :guests, :start)
  end
end
