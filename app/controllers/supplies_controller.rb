class SuppliesController < ApplicationController
  before_action :require_user
  load_and_authorize_resource :event
  load_and_authorize_resource :supply, through: :event

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Events", :events_path

  def index
    #TODO figure out how to add param to breadcrumb paths
    add_breadcrumb "Event",    event_path(@event)
    add_breadcrumb "Supplies", event_supplies_path(@event)

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

  def new
    add_breadcrumb "Event",    event_path(@event)
    add_breadcrumb "Supplies", event_supplies_path(@event)
    add_breadcrumb "Supply",   new_event_supply_path(@event)
  end

  def edit
    add_breadcrumb "Event",    event_path(@event)
    add_breadcrumb "Supplies", event_supplies_path(@event)
    add_breadcrumb "Supply",   edit_event_supply_path(@event)

  end

  def update
    ## not updating properly
    @supply.update_attributes supply_params

    if @supply.save
      redirect_to event_supplies_path
    else
      render_template :new
    end
  end

  def destroy
    if @supply.delete
      flash[:success] = "Supply Deleted."
    else
      flash[:danger] = "Supply wasn't deleted."
    end

    redirect_to event_supplies_path(@event)
  end

  private

  def supply_params
    params.require(:supply).permit(:name, :purchased, :cost, :vendor, :total_needed)
  end
end
