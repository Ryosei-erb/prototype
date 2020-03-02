Rails.application.routes.draw do
  get "/", to: "products#new"
  resources :products
  resources :categories do
    resource :product_taxons, only: [:create, :destroy]
  end
end
