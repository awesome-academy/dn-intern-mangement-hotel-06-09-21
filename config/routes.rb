Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "static_pages/contact"
    get "static_pages/about"
    get "static_pages/help"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/search", to: "rooms#search"
    resources :carts, only: :index do
      collection do
        post "add"
        post "change"        
        delete "remove"
      end
    end
    resources :users
    resources :rooms
    resources :account_activations, only: :edit
    namespace :admin do
      root "admins#index"
    end
  end
end
