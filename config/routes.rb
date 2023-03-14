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

  resources :users do
    resources :products
  end
  resources :orders, only: [:new, :create, :show]
  resources :categories do
    resources :products
  end
  resources :line_items


  resources :products do
    resources :line_items, only: [:create, :destroy]
  end

  resource :cart

  
end
