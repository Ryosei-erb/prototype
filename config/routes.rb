Rails.application.routes.draw do
  root "products#new"
  resources :products, only: [:index, :show, :new, :create] do
    collection do
      post "/checkout/:id", to: "products#checkout", as: "checkout"
    end
  end
  resources :categories, only: [:show]
end
