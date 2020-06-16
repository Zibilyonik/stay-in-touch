Rails.application.routes.draw do

  root 'posts#index'
  get 'users/:id/friendship/create', to: 'friendships#create'
  post 'users/:id/friendship/create', to: 'friendships#create'
  post 'friendship/create', to: 'friendships#create'
  devise_for :users

  resources :users, only: [:index, :show] do
    resources :friendships
  end
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
