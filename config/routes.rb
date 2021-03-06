Fingerprints::Application.routes.draw do
  resources :users do
    member do
      get :following, :followers,:stats,:calendar,:unlink_facebook
    end
  end
  resources :microposts do
    member do
      get :set_private, :set_public
    end
  end
  resources :action_posts do
    member do
      get :set_private, :set_public,:publish_on_fb
    end
  end

  resources :sessions,      only: [:new, :create, :destroy]
  resources :microposts,    only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :action_posts,  only: [:create, :destroy, :edit, :update]
  resources :activities,  only: [:new,:create, :destroy, :edit, :update]  
  resources :achievements,  only: [:new,:create, :destroy, :edit, :update]

  root to: 'static_pages#home'

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

  match '/auth/:provider/callback', :to => 'sessions#fb_auth'
  match '/auth/failure', :to => 'sessions#failure'

  match '/activities', to: 'activities#index'
  match '/activities/admin', :controller => 'activities', :action => 'admin_activities'
  
  match '/achievements', to: 'achievements#index'
  match '/achievements/admin', :controller => 'achievements', :action => 'admin_achievements'

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
end
