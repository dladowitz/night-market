class MealsController < ApplicationController
  before_action :require_user
  load_and_authorize_resource :event, except: :event_select
  load_and_authorize_resource :meal, through: :event, except: :event_select

  def index
  end

  def event_select
    @events = current_user.events
  end

  def new
  end

  def create
    @meal = @event.meals.build meal_params

    if @meal.save
      flash[:success] = "Hi Five. Meal created successfully."
      redirect_to event_meal_path(@event, @meal)
    else
      flash[:danger] = "Slow your roll partna. Meal wasn't created properly"
      render :new
    end
  end

  def show
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

  def destroy
    @meal.delete
    redirect_to event_meals_path(@event)
  end

  private

  def meal_params
    params.require(:meal).permit(:category, :guests, :start, :ignore_warnings)
  end
end
