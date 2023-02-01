Rails.application.routes.draw do
  get 'spending_plan/new'
  get 'comments/index'
  get 'room/index'
  devise_for :users
  root "posts#index"
  resources :posts
  resources :followers
  resources :spending_plan
  get "spending_plan", to: "spending_plan#index", as: :plan_search
  post "spending_plan_post", to: "spending_plan#create", as: :spending_plan_post
  as :spending_plan do
    post "spending_plan", to: "spending_plan#create", as: :spending_plans
  end
  as :followers do
    post 'followers_by', to: "followers#follow", as: :follow
  end
  as :post do
    post "posts/:id", to: "posts#update", as: :post_update
    delete "posts/:id", to: "posts#destroy", as: :post_delete
  end
  as :user do
    get 'logout', to: "devise/sessions#destroy"
    get "user/:id", to: "users#show", as: :profile
    get "users", to: "users#index", as: :users
    delete "users/:id", to: "users#destroy", as: :user_destroy
    get 'followers_to', to: "users#follow_to", as: :follow_to
    get 'followers_by', to: "followers#index", as: :follow_by
  end
  get "spending_plan/:id/export.pdf", to: "spending_plan#export", as: :export
end
