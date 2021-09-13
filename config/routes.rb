Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
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
    resource :cart, only: :show 
    resources :receipt_details, only: %i(create update destroy) do
      collection do
        post "update_cart"
        delete "destroy_cart"
      end
    end
    resources :users
    resources :rooms
    resources :receipts, only: %i(index show create)
    resources :account_activations, only: :edit
    # namespace :admin do
    #   resources :receipts, only: [:index]
    # end
  end
end
