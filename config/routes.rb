Rails.application.routes.draw do
  root "posts#index"
  resources :users
  resources :posts
  get "login", to: "users#login"
  post "login", to: "users#accept"
end
