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
    
    # 新規登録者数
    daily_new_active_users = User.where("DATE(created_at) BETWEEN ? AND ? AND user_status = ?", start_date, end_date, true)
                              .group("DATE(created_at)")
                              .order("DATE(created_at)")
                              .count

    @daily_new_active_users = {}
    
    start_date.upto(end_date) do |date|
      date_str = date.strftime("%Y-%m-%d")
      @daily_new_active_users[date_str] = daily_new_active_users[date_str] || 0
    end
    
  end
end
