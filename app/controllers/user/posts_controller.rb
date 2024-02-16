class User::PostsController < ApplicationController

  def new
    @post = Post.new
    @user_current = current_user
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to user_posts_path
  end
  
  def index
    @user_current = current_user
    @posts = Post.all
    @comment = Comment.new
  end

  def show
    @post = Post.find(params[:id])
    @user_current = current_user
    @comment = Comment.all
    @comment = Comment.new
  end
  
  private
  
  def post_params
    params.require(:post).permit(:image,:body)
  end
end
