class User::EventsController < ApplicationController
  before_action :authenticate_user!
  def new
    @event = Event.new
  end
  
  def index
    @user = current_user
    @events = @user.events
    @event = Event.new
  end
  
  def create
    @event = current_user.events.new(event_params)
    @event.save
    @events = current_user.events
    render json: @events
    # redirect_to user_user_events_path
  end
  
  def show
    
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  private
  
  def event_params
    params.require(:event).permit(:title, :start, :end, :time,)
  end
end
