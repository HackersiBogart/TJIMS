Rails.application.routes.draw do
  get 'emails/new'
  get 'emails/create'
  resources :customer_orders do
    collection do
      get :fetch_products
      get :fetch_paint_colors
    end
  end
  get 'sales/index'
  get 'reports/index'
  
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords',
    shared: 'admins/shared'
  }
  
  get 'mix/new'
  get 'mix/create'
  get 'mix/index'
  post 'mix/deduct_stock', to: 'mix#deduct_stock', as: 'mix_deduct_stock'


  resources :colors, only: [] do
    member do
      get :products
    end
  end
  
  resources :products, only: [] do
    member do
      get :paint_colors
    end
  end

  resources :select, only: [:show]

  namespace :admin do
    get 'sales/download_pdf', to: 'sales#download_pdf', as: :download_pdf_sales
    get 'movement_histories/add_stock'
    get 'movement_histories/deduct_stock'
    resources :stock_movements, only: [:index, :show,:new, :create]

    resources :products do
      resources :product_stocks, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    end


    resources :users do
      member do
        post :send_welcome_email
      end
    end


    
    resources :orders do
      member do
        get 'change_fulfilled', to: 'orders#change_fulfilled'
        get :reference_image
      end
      
    end
 
    resources :mixture_thirds
    resources :mixture_details

    resources :mixtures do
      member do
        post :change_fulfilled
      end
    end
    resources :sales, only: [:index, :show]

    resources :mix, only: [:index, :create] do
      post 'deduct_stock', on: :collection
    end

    resources :primary_colors do
      resources :primary_color_stocks, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    end

    resources :paint_colors do
      resources :stocks, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    end
    resources :colors
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
  resources :primary_colors, only: [:show]
  resources :premadecolors, only: [:show]
  resources :premadeproducts, only: [:show]
  resources :order_mail, only: [:new]
  resources :emails, only: [:new, :create]
  
  get 'reports', to: 'reports#index'
  get "admin" => "admin#index"
  get "mix" => "mix#index"
  get "cart" => "carts#show"
  post "checkouts" => "checkouts#create"
  get 'summary', to: 'summary#show'
  get 'summary/:id', to: 'summary#show', as: 'order_summary'
  get 'sales', to: 'sales#index'
  get 'select', to: 'select#show'
  get 'premade', to: 'premade#index', as: 'premade'
   get 'tomix', to: 'tomix#index', as: 'tomix'
    get 'premadecolors', to: 'premadecolors#show', as: 'premadecolors'
    get 'stock_movements', to: 'stock_movements#show', as: 'stock_movements'
  post 'send_mail', to: 'order_mail#send_mail'
  get 'order_mail', to: 'order_mail#new', as: 'order_mail'
  get 'emails', to: 'emails#new'
  get "/test", to: "application#test"
  get '/colors/:id/products', to: 'colors#products'
get '/products/:id/paint_colors', to: 'products#paint_colors'

  
end
