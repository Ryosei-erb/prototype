Rails.application.routes.draw do
  root "products#new"
  get "/products/search", to: "products#search" 
  resources :products, only: [:index, :show, :new, :create] do
    collection do
      post "/checkout/:id", to: "products#checkout", as: "checkout"
    end
  end
  resources :categories, only: [:show]
  resources :users, only: [:create]
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new", as: "new_login"
  post "/login", to: "sessions#create", as: "create_login"
  delete "/logout", to: "sessions#destroy", as: "logout"
end
