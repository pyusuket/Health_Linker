class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all.page(params[:page]).per(30)
  end
end
