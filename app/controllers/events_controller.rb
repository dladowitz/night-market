class EventsController < ApplicationController
  before_filter :load_event, only: [:show, :edit, :update, :destroy]

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
    unless @event
      flash[:danger] = "Easy tiger, that's not an event I've ever heard of."
      redirect_to events_path
    end
  end

  def edit
    unless @event
      flash[:danger] = "Easy tiger, that's not an event I've ever heard of."
      redirect_to events_path
    end
  end

  def update
    if @event
      @event.update event_params
      redirect_to @event
    else
      flash[:danger] = "Easy tiger, that's not an event I've ever heard of."
      redirect_to events_path
    end
  end

  def destroy
    if @event
      @event.delete
      redirect_to events_path
    else
      flash[:danger] = "Easy tiger, that's not an event I've ever heard of."
      redirect_to events_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :guests, :location, :start_date, :end_date,
                                  :vegetarian, :vegan, :gluten_free, :dairy_free )
  end

  def load_event
    @event = Event.find_by_id params[:id]
  end
end
