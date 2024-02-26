class User::HomesController < ApplicationController
  def mypage
    @user_current = current_user
    @user = current_user 
    @posts = @user.posts.order(created_at: :desc)
  end
end
