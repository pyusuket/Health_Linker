Rails.application.routes.draw do
  root 'user/homes#index'
  
  devise_for :user, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  devise_scope :user do
    post "users/guest_sign_in", to: "user/sessions#guest_sign_in"
  end
  
  namespace :admin do
  end
  
  namespace :user do
    resources :users
    resources :posts
  end
end
