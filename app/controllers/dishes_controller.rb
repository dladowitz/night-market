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
    @dish = Dish.new(dish_params)

    respond_to do |format|
      if @dish.save
        format.html { redirect_to @dish, notice: 'Dish was successfully created.' }
        format.json { render :show, status: :created, location: @dish }
      else
        format.html { render :new }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @dish.update(dish_params)
        format.html { redirect_to @dish, notice: 'Dish was successfully updated.' }
        format.json { render :show, status: :ok, location: @dish }
      else
        format.html { render :edit }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
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
      params.require(:dish).permit(:vendor, :servings, :category, :ordered, :vegetarian, :vegan, :gluten_free, :dairy_free, :needs_ice, :transport_method, :transport_time)
    end
end
