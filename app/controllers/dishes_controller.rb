class DishesController < ApplicationController
  before_action :set_event_and_meal
  before_action :set_dish, only: [:show, :edit, :update, :destroy]  # before_action is the new name for before_filters

  def index
    @dishes = @meal.dishes
  end

  def new
    @dish = @meal.dishes.build
  end

  def create
    @dish = @meal.dishes.build dish_params

    if @dish.save
      flash[:success] = "Dish was successfully created."
      redirect_to event_meal_dish_path(@event, @meal, @dish)
    else
       render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @dish.update(dish_params)
      flash[:success] = 'Dish was successfully updated.'
      redirect_to event_meal_dish_path(@event, @meal, @dish)
    else
      flash[:success] = 'Dish was not updated.'
      render :edit
    end
  end

  def destroy
    @dish.destroy
    respond_to do |format|
      format.html { redirect_to dishes_url, notice: 'Dish was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_dish
      @dish = Dish.find_by_id params[:id]

      unless @dish
        flash[:danger] = "Listen up pilgram. That's not a dish we've seen round these parts."
        redirect_to event_meal_dishes_path(@event, @meal)
      end
    end

    def set_event_and_meal
      @event = Event.find params[:event_id]
      @meal  = Meal.find  params[:meal_id]
    end

    def dish_params
      params.require(:dish).permit(:name, :vendor, :servings, :category, :ordered, :vegetarian, :vegan, :gluten_free, :dairy_free, :needs_ice, :transport_method, :transport_time)
    end
end
