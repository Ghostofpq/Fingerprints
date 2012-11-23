Fingerprints::Application.routes.draw do
  resources :action_posts


  get "actions/index"

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts do
    member do
      get :set_private, :set_public
    end
  end
  # resources :users
  resources :sessions,      only: [:new, :create, :destroy]
  resources :microposts,    only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  root to: 'static_pages#home'

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  
  match '/actions', to: 'actions#index'
  
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
end
