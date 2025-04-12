Rails.application.routes.draw do
  resources :products
  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  resources :carts, only: [:show, :destroy]
  
  resources :line_items, only: [:create, :destroy] do
    member do
      patch :increase
      patch :decrease
    end
  end
  
  root 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'upload', to: 'uploads#create'
end
