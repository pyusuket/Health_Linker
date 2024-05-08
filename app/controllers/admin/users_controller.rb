class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.all.page(params[:page]).per(30)
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "削除しました。"
      redirect_to admin_users_path
    else
      flash[:alert] = "削除できませんでした。"
      render :index
    end
  end
  
end