class User::PostsController < ApplicationController
  before_action :authenticate_user!
   
  def new
    @post = Post.new
    @tags = Tag.all
    6.times { @post.images.build }
  end
  
  def create
  @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_path, notice: '投稿が完了しました'
    else
      render :new
    end
  end
  
  def index
    @posts = Post.order(created_at: :desc)
    @comment = Comment.new
  end

  def show
    @post = Post.find(params[:id])
    @post.increment!(:views_count)
    @user = @post.user
    @comment = Comment.all
    @comment = Comment.new
  end
  
  def edit
    @post = Post.find(params[:id])
    @selected_images = @post.images
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集が完了しました。"
      redirect_to user_post_path(@post.id)
    else
      flash[:alert] = "編集ができませんでした。"
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "削除が完了しました。"
    else
      flash[:alert] = "削除に失敗しました。"
    end
    redirect_to user_homes_mypage_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:body,images: [], tag_ids: [])
  end
  
end
