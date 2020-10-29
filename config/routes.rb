Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    authenticated :user do
      root :to => 'users#show', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  resources :users, only: [:show]
  resources :books
end
