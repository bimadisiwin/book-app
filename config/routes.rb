Rails.application.routes.draw do
  resources :books
  root "books#index"
  resources :users, only: [:new, :create, :index]
end
