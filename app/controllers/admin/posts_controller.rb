class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @posts = Post.order(views_count: :desc).page(params[:page]).per(30)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.all
  end
  
  def destroy
    @post = User.find(params[:id])
    if @post.destroy
      flash[:notice] = "削除しました。"
      redirect_to admin_posts_path
    else
      flash[:alert] = "削除できませんでした。"
      render :index
    end
  end
end
