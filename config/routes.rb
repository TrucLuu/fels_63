Rails.application.routes.draw do
  get 'lessons/index'

  namespace :admin do
    resources :lessons
  end
  namespace :admin do
    resources :users
  end
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users
  resources :account_activations, only: :edit
  resources :password_resets, except: [:destroy, :index]
  resources :lessons
end
