Rails.application.routes.draw do
  resources :trips
  resources :users
  resource :auth, only: [:create, :destroy], controller: :auth
end
