class User::FollowsController < ApplicationController
  before_action :authenticate_user!
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end
  
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to  request.referer
  end
  
  def followings
    @user_current = current_user
    user = User.find(params[:user_id])
    @user = User.find(params[:user_id])
    @users = user.followings
  end
  
  def followers
    @user_current = current_user
    user = User.find(params[:user_id])
    @user = User.find(params[:user_id])
    @users = user.followers
  end
end
