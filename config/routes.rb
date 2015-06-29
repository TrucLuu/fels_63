Rails.application.routes.draw do
  namespace :admin do
    resources :words
    resources :users
    resources :categories
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
  resources :categories, only: :index
end
