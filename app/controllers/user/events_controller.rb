class User::EventsController < ApplicationController
  def new
    @event = Event.new
  end
  
  def index
    @user = current_user #User.find(params[:user_id])
    @events = @user.events
    @event = Event.new
  end
  
  def create
    @event = current_user.events.new(event_params)
    @event.save
    redirect_to user_user_events_path
  end
  
  def show
    
  end
  
  private
  
  def event_params
    params.require(:event).permit(:title, :start, :end)
  end
end
