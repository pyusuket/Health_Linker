class User::UsersController < ApplicationController
  before_action :is_current_user, only: [:edit, :update, :nices, :destroy]
  
  def index
    @user_current = current_user
    @user = current_user 
    @posts = @user.posts.order(created_at: :desc)
  end
  
  def show
    @user_current = current_user
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end
  
  def edit
    @user_current = current_user
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_user_path
    else
      render :edit
    end
  end
  
  def nices
    @user_current = current_user
    @user = User.find(params[:id])
    @posts = @user.nices.includes(:post).map(&:post)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:profile_image, :user_name, :introduction, :birthday, :sex, :postal_code, :prefecture, :city, :apartment)
  end
  
  def is_current_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_posts_path
    end
  end
end
