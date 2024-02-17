class User::PostsController < ApplicationController

  def new
    @post = Post.new
    @user_current = current_user
    @tags = Tag.all
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
  
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
    params.require(:post).permit(:images,:body)
  end
  
end
