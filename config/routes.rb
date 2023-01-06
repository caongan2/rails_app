Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  resources :posts
  as :user do
    get 'logout', to: "devise/sessions#destroy"
  end

end
