Rails.application.routes.draw do
  get 'events', to: "user/events#index"
  root 'user/homes#mypage'
  
  devise_scope :user do
    get  'users/sign_out',      to: 'user/sessions#destroy'
    post "users/guest_sign_in", to: "user/sessions#guest_sign_in"
  end
  
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions:      'user/sessions'
  }
  
  # userのルーティング
  namespace :user do
    get '/homes/mypage' => 'homes#mypage', as: 'homes_mypage'
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      member do 
        get "nices" 
      end 
      resource :follow,         only: [:create, :destroy]
      get "followings" => "follows#followings", as: "followings"
      get "followers"  => "follows#followers", as: "followers"
      resources :messages,      only: [:index, :show, :create] 
      resources :notifications, only: [:index, :show] 
      resources :events 
  end
    resources :posts do
      resources :comments, only: [:create]
      resource  :nices,    only: [:create, :destroy]
      resources :searches, only: [:index]
    end
  end
  
  # adminのルーティング
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    get '/homes/top' => 'homes#top', as: 'homes_top'
    resources :users
    resources :posts
  end
end
