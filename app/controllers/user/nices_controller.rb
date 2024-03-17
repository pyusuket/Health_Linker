class User::NicesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  
  def create
    nice = @post.nices.new(user: current_user)
    nice.save
    # セッションにリクエストが発生したページのURLを保存する
    session[:return_to] ||= request.referer
    # セッションからリダイレクト先のURLを取得し、存在すればリダイレクト
    redirect_to session.delete(:return_to) || user_posts_path(@post.user, @post)
  end

  def destroy
    nice = @post.nices.find_by(user: current_user)
    nice.destroy
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to) || user_posts_path(@post.user, @post)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end