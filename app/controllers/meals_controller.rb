class MealsController < ApplicationController
  before_action :require_user
  load_and_authorize_resource :event, except: :event_select
  load_and_authorize_resource :meal, through: :event, except: [:event_select, :create]
  before_action :decorate_meals, only: [:new, :edit, :show]

  add_breadcrumb "Home",   :root_path
  add_breadcrumb "Events", :events_path

  def index
    add_breadcrumb "Event", event_path(@event)
    add_breadcrumb "Meals", event_meals_path
  end

  def event_select
    @events = current_user.events
  end

  def new
  end

  def create
    @meal = @event.meals.build meal_params_with_datetime_conversion
    if @meal.save
      flash[:success] = "Hi Five. Meal created successfully."
      redirect_to event_meal_path(@event, @meal)
    else
      flash[:danger] = "Slow your roll partna. Meal wasn't created properly"
      render :new
    end
  end

  def show
    #TODO figure out how to add all as before_action. Weird syntax errors.
    add_breadcrumb "Event", event_path(@event)
    add_breadcrumb "Meals", event_meals_path
    add_breadcrumb "Meal", event_meal_path(@event, @meal)
  end

  def edit
  end

  def update
    @meal.update_attributes meal_params_with_datetime_conversion

    if @meal.save
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
    params.require(:meal).permit(:category, :guests, :start, :ignore_warnings, :cost)
  end

  def decorate_meals
    @meal = @meal.decorate
  end

  def meal_params_with_datetime_conversion
    if meal_params[:start]
      meal_params.merge(start: bootstrap_datetime_to_rb_datetime(meal_params[:start]))
    else
      meal_params
    end
  end
end
