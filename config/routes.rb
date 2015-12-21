Rails.application.routes.draw do
  # Duplicate and unnecessary
  #get 'user_sessions/new'
  #get 'user_sessions/create'
  #get 'user_sessions/destroy'
  #resources :users

  # Resources
  resources :courses
  resources :user_sessions
  resources :users
  resources :pages

  #Root
  root 'pages#index'

  get 'home', :to => 'pages#index', :as => :home
  get 'contact', :to => 'pages#contact', :as => :contact

  #Get
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
end
