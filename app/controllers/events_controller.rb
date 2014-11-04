class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :guests, :location, :start_date, :end_date )
  end
end
