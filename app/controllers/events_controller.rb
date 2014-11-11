class EventsController < ApplicationController
  before_action :require_user
  before_action :load_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
     @event = Event.new(event_params)

     if @event.save
       flash[:success] = "Nice one. Event created successfully."
       redirect_to events_path
     else
       flash[:danger] = "Oh Frak, that didn't work."
       render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @event.update event_params
      redirect_to @event
    else
      flash[:danger] = "Could not update."
      render :edit
    end
  end

  def destroy
    @event.delete
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :guests, :location, :start_date, :end_date,
                                  :vegetarian, :vegan, :gluten_free, :dairy_free )
  end

  def load_event
    @event = Event.find_by_id params[:id]

    unless @event
      flash[:danger] = "Easy tiger, that's not an event I've ever heard of."
      redirect_to events_path
    end
  end
end
