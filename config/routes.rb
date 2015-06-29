Rails.application.routes.draw do
  namespace :admin do
    root "dashbroads#index"
    resources :words
    resources :users
    resources :categories
  end
  
  resources :password_resets, except: [:destroy, :index]
  resources :categories, only: :index
  resources :relationships, only: [:create, :destroy]
  resources :words
  resources :users
  resources :account_activations, only: :edit
  resources :results, only: :show

  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  get "users/:id/:type" => "relationships#index", as: "follows"

end
