class SuppliesController < ApplicationController
  before_action :require_user
  load_and_authorize_resource :event

  def index
    @supplies = @event.supplies
  end

  def create
    supply = @event.supplies.build supply_params
    if supply.save
      redirect_to event_supplies_path
    else
      render :new
    end
  end


  private

  def supply_params
    params.require(:supply).permit(:name, :purchased, :cost, :vendor, :total_needed)
  end

  # def meal_params
  #   params.require(:meal).permit(:category, :guests, :start, :ignore_warnings, :cost)
  # end

end
