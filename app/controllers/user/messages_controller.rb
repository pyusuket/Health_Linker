class User::MessagesController < ApplicationController
  def index
    sent_messages = Message.where(sender_id: current_user.id)
    received_messages = Message.where(receiver_id: current_user.id)
    @messages = (sent_messages + received_messages).sort_by(&:created_at).reverse
  end
  
  def show
    @user = User.find(params[:user_id])
    @message = Message.new
    @messages = Message.where(sender_id: [@user_current.id, @user.id], receiver_id: [@user_current.id, @user.id]).order(created_at: :desc)
    @messages.where(receiver_id: @user_current.id, read: false).update_all(read: true)
  end
  
  def create
  @message = Message.new(message_params)
  @message.sender_id = current_user.id
  @message.receiver_id = params[:user_id] 

    if @message.save
      redirect_to user_user_message_path(@message.receiver_id, @message.id)
    else
      flash.now[:alert] = "メッセージの送信に失敗しました。"
      render :show
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content)
  end
end