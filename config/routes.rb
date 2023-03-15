Rails.application.routes.draw do
  get 'orders/new'
  get 'orders/create'
  get 'orders/show'
  root 'products#index'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  get '/orders/new', to: 'orders#new', as: 'new_order'
  delete 'cart', to: 'carts#destroy', as: :clear_cart
  get '/bootstrap', to: 'static#bootstrap'
  get 'my_products', to: 'products#my_products'
  get '/processing_order', to: 'orders#processing', as: 'processing_order'

  resources :users do
    resources :products
    get 'password_edit', on: :member
  end

  resources :orders, only: [:new, :create, :show]

  resources :categories do
    resources :products
  end

  resources :line_items
  patch 'users/:id/update_password', to: 'users#update_password', as: 'update_password_user'

  

  resources :products do
    resources :line_items, only: [:create, :destroy]
  end

  resource :cart

  
end
