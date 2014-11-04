class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    flash[:success] = "Nice one. Event created successfully."
    redirect_to events_path
  end

  def show
    @event = Event.find_by_id params[:id]

    unless @event
      flash[:danger] = "That's not an event I've ever heard of."
      redirect_to events_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :guests, :location, :start_date, :end_date )
  end
end
