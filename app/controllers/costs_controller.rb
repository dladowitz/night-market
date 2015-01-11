class CostsController < ApplicationController
  authorize_resource :event


  def index
    # Problem loading event through cancan for some reason. Need to do it here.
    @event = Event.find params[:event_id]

    add_breadcrumb "Event",   event_path(@event)
    add_breadcrumb "Costs",   event_costs_path(@event)

    @total_cost = @event.current_spend
    @cost_items = @event.get_cost_items
  end
end
