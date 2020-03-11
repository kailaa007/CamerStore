Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users , only: [:create] do
    collection do
      post "/login", to: "users#login"
    end
  end
  resources :categories
  resources :products
  resources :carts, only: [:create] do
    collection do
      get "/user_cart", to: "carts#cart_check"
    end
  end
end
