Rails.application.routes.draw do
  # Resources
  resources :courses do
    resources :courses_users
  end

  resources :user_sessions
  resources :users
  resources :pages

  #Root
  root 'pages#index'

  #Get
  get 'home', :to => 'pages#index', :as => :home
  get 'contact', :to => 'pages#contact', :as => :contact

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
end
