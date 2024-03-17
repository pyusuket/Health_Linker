class User::SearchesController < ApplicationController
  def index
    @user_current = current_user
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.order(created_at: :desc)
  end
end
