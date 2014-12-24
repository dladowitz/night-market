class EventsController < ApplicationController
  before_action :require_user

  load_and_authorize_resource except: :index

  def index
    # For some reason load_resource is returning nothing. So need to load and authorize this way.
    authorize! :index, Event

    if current_user.admin?
      @events = Event.all
    else
      @events = current_user.events
    end
  end

  def new
  end

  def create
    @event = current_user.events.new(event_params)

     if @event.save
       flash[:success] = "Nice one. Event created successfully."
       redirect_to event_path(@event)
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
    params.require(:event).permit(:name, :guests, :budget, :location, :start_date, :end_date,
                                  :vegetarian, :vegan, :gluten_free)
  end
end
