class Admin::PostsController < ApplicationController
  def index
    @posts = Post.order(views_count: :desc).page(params[:page]).per(30)
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
