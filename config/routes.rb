Rails.application.routes.draw do
  get 'mix/new'
  get 'mix/create'
  get 'mix/index'
  post 'mix/deduct_stock', to: 'mix#deduct_stock', as: 'mix_deduct_stock'
  namespace :admin do
    resources :mix, only: [:index, :create, :deduct] do
      post 'deduct_stock', on: :collection
    end
    resources :primary_colors
    resources :orders
    resources :products
    resources :paint_colors do
    resources :stocks, only: [:index, :show, :new, :create, :edit, :update, :destroy]
      
    end
    resources :colors

  end

  
  
  devise_for :admins, path: 'admins'
  
  namespace :admin do
    resources :products
  end
  # Define your application routes per the DSL in https://guides.rubyonails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  authenticated :admin_user do
    root to: "admin#index", as: :admin_root
  end

  # Define routes for the checkouts controller outside the admin namespace
  resources :checkouts, only: [:new, :create]
  

  resources :colors, only: [:show]
  resources :products, only: [:show]
  resources :paint_colors, only: [:show]

  get "admin" => "admin#index"
  get "mix" => "mix#index"
  get "cart" => "carts#show"
  post "checkouts" => "checkouts#create"
  get 'summary', to: 'summary#show'
  get 'summary/:id', to: 'summary#show', as: 'order_summary'
 
end
 