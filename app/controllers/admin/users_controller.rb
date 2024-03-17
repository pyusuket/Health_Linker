class Admin::UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]).per(30)
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