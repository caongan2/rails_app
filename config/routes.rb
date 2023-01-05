Rails.application.routes.draw do
  root "posts#index"
  resources :users
  resources :posts
  get "login", to: "users#login"
  get "logout", to: "users#logout"
  post "login", to: "users#accept"
end
