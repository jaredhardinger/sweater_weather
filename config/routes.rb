Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :forecast, only: [:index]
      get "book-search", to: "book#index"
      post "users", to: "users#create"
      post "sessions", to: "users#login"
    end
  end
end
