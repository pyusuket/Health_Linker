class User::NicesController < ApplicationController
    before_action :find_post
  
  def create
    nice = @post.nices.new(user: current_user)
    if nice.save
      redirect_to user_posts_path(@post.user, @post), notice: 'いいねしました'
    else
      redirect_to user_posts_path(@post.user, @post), alert: 'いいねできませんでした'
    end
  end

  def destroy
    nice = @post.nices.find_by(user: current_user)
    if nice.destroy
      redirect_to user_posts_path(@post.user, @post), notice: 'いいねを取り消しました'
    else
      redirect_to user_posts_path(@post.user, @post), alert: 'いいねを取り消せませんでした'
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end