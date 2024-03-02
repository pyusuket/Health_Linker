class ApplicationController < ActionController::Base
  before_action :set_unread_messages_count
  before_action :set_user_current
  
  private
  
  def set_user_current
    @user_current = current_user
  end
  
  def set_unread_messages_count
    if current_user
      @unread_messages_count = Message.where(receiver_id: current_user.id, read: false).count
    end
  end
  
end
