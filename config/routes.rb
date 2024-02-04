Rails.application.routes.draw do
  devise_for :user, skip: [:passwords], controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions'
  }
  
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :user do
    resources :users
  end
end
