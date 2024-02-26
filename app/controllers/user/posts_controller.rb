class User::PostsController < ApplicationController

  def new
    @post = Post.new
    @user_current = current_user
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
    @user_current = current_user
    @posts = Post.order(created_at: :desc)
    @comment = Comment.new
  end

  def show
    @post = Post.find(params[:id])
    @post.increment!(:views_count)
    @user = @post.user
    @user_current = current_user
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
  
end
