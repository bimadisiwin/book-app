# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    authenticated :user do
      root :to => 'books#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  
  scope '(:locale)' do
    resources :books
  end

  resources :users, only: [:show, :index]

  resources :followings, only: [:index]
  resources :followings do
    get :index, on: :member
  end

  resources :relationships, only: [:create, :destroy]
end
