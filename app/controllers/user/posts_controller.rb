class User::PostsController < ApplicationController
  before_action :is_current_user, only: [:destroy]
   
  def new
    @post = Post.new
    @tags = Tag.all
    6.times { @post.images.build }
  end
  
  def create
    @post = current_user.posts.build(post_params)
  
    if @post.save
      # 画像が送信されている場合のみ処理を行う
      if params[:images].present?
        params[:images].each do |image|
          @post.images.attach(image)
        end
      end
  
      # タグの処理
      tag_ids = params[:post][:tagging]
      @post.tags << Tag.where(id: tag_ids)
  
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
    params.require(:post).permit(:images,:body)
  end
  
  def is_current_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to user_posts_path
    end
  end
  
end
