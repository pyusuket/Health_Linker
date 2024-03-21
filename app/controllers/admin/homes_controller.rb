class Admin::HomesController < ApplicationController
  def top
    @users = User.all
    # 基準日
    start_date = Date.new(2024, 2, 1)
    end_date = Date.today
  
    # アクティブユーザー
    daily_active_users = User.where("created_at >= ? AND user_status = ?", start_date, true)
                              .group("DATE(created_at)")
                              .order("DATE(created_at)")
                              .count
  
    @daily_active_users = {}
    accumulated_count = 0
  
    start_date.upto(end_date) do |date|
      date_str = date.strftime("%Y-%m-%d")
      count = daily_active_users[date_str] || 0
      accumulated_count += count
      @daily_active_users[date_str] = accumulated_count
    end
    # JavaScriptに絞り込みデータを渡す
    @javascript_data = @daily_active_users.to_json

    # 新規登録者数
    daily_new_active_users = User.where(created_at: start_date.beginning_of_day..end_date.end_of_day, user_status: true)
                              .group("DATE(created_at)")
                              .order("DATE(created_at)")
                              .count

    @daily_new_active_users = {}
    
    start_date.upto(end_date) do |date|
      date_str = date.strftime("%Y-%m-%d")
      @daily_new_active_users[date_str] = daily_new_active_users[date_str] || 0
    end
    
    # ページビュー数の表示（人気の投稿）
    @top_page_views = Post.order(views_count: :desc).limit(10).pluck(:id)
    
    page_views_data = {}
    @top_page_views.each do |page_id|
      page_views_data[page_id] = Post.find(page_id).views_count
    end
    
    @page_views_data = page_views_data
    
    
  end
end
