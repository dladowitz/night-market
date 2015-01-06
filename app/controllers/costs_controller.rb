class CostsController < ApplicationController
  load_and_authorize_resource :event

  add_breadcrumb "Home",    :root_path
  add_breadcrumb "Events",  :events_path

  def index

    add_breadcrumb "Event",   event_path(@event)
    add_breadcrumb "Costs",   event_costs_path(@event)

    @total_cost = @event.current_spend
    @cost_items = @event.get_cost_items
  end
end
