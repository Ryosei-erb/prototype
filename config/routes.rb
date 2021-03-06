Rails.application.routes.draw do
  root "homes#index"
  get "/products/search", to: "products#search"
  get "/products/:id/location", to: "products#location"
  get "/products/:id/sold", to: "products#sold", as: "sold"
  post "/products/:id/sold", to: "products#resale", as: "resale"
  resources :products, only: [:index, :show, :new, :create, :destroy] do
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
  get "/guest", to: "sessions#guest"
  resources :homes, only: [:index]
  resources :rooms, only: [:show, :create]
  resources :messages, only: [:create]
  resources :maps, only: [:index]
  get "/maps/search", to: "maps#search"
  resources :cards, only: [:show, :new] do
    collection do
      post "pay", to: "cards#pay"
    end
  end
end
