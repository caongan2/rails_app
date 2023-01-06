Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  resources :posts
  as :user do
    get 'logout', to: "devise/sessions#destroy"
    get "user/:id", to: "users#show", as: :profile
    get "users", to: "users#index", as: :users
  end

end
