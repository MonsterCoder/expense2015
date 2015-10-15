Rails.application.routes.draw do
  resources :trips
  resources :users
  resources :admin
  resource :auth, only: [:create, :destroy], controller: :auth
end
