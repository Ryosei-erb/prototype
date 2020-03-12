Rails.application.routes.draw do
  get 'maps/index'
  root "homes#index"
  get "/products/search", to: "products#search"
  resources :products, only: [:index, :show, :new, :create] do
    collection do
      post "/checkout/:id", to: "products#checkout", as: "checkout"
    end
    resource :favorites, only: [:create, :destroy]
  end
  resources :categories, only: [:show]
  resources :users, only: [:show, :create]
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new", as: "new_login"
  post "/login", to: "sessions#create", as: "create_login"
  delete "/logout", to: "sessions#destroy", as: "logout"
  resources :homes, only: [:index]
  # mount ActionCable.server => "/cable"
  resources :rooms, only: [:show, :create]
  resources :messages, only: [:create]
  resources :maps, only: [:index]
  get "/maps/search", to: "maps#search"
end
