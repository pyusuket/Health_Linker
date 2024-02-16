class User::UsersController < ApplicationController
  def index
    @user_current = current_user
    @post = Post.all
  end
  
  def show
    @user_current = current_user
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def edit
    @user_current = current_user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_user_path
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:profile_image, :user_name, :introduction, :birthday, :sex, :postal_code, :prefecture, :city, :apartment)
  end
end
