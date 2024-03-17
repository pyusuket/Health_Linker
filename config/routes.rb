Rails.application.routes.draw do
  
  root to: 'user/homes#mypage'
   # Devise routes
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions:      'user/sessions'
  }
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # User routes
  namespace :user do
    get '/homes/mypage', to: 'homes#mypage', as: 'homes_mypage'
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resource :follow, only: [:create, :destroy]
      get "followings" => "follows#followings", as: "followings"
      get "followers"  => "follows#followers", as: "followers"
      resources :messages, only: [:index, :show, :create] 
      resources :notifications, only: [:index, :show] 
      member do 
        get "nices" 
      end 
    end
    resources :events 
    resources :posts do
      resources :comments, only: [:create]
      resource  :nices,    only: [:create, :destroy]
      resources :searches, only: [:index]
    end
  end
  
  # Admin routes
  namespace :admin do
    get '/homes/top', to: 'homes#top', as: 'homes_top'
    resources :users
    resources :posts
  end

  # Devise scopes
  devise_scope :user do
    get  'users/sign_out', to: 'user/sessions#destroy'
    get "users/guest_sign_in", to: "user/sessions#guest_sign_in"
  end
end