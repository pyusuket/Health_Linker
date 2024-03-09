class User::HomesController < ApplicationController
  before_action :authenticate_user!
  def mypage
    @user = current_user 
    @posts = @user.posts.order(created_at: :desc)
  end
end
