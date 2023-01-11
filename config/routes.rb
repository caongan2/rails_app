Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  resources :posts
  resources :followes
  as :followes do
    post 'followes_by', to: "followes#follow", as: :follow
  end
  as :post do
    post "posts/:id", to: "posts#update", as: :post_update
  end
  as :user do
    get 'logout', to: "devise/sessions#destroy"
    get "user/:id", to: "users#show", as: :profile
    get "users", to: "users#index", as: :users
    get 'followes_to', to: "users#follow_to", as: :follow_to
  end

end
