Rails.application.routes.draw do
  resources :expenses
  resources :users
  resources :admin, only: [:index]
  resource :auth, only: [:create, :destroy], controller: :auth
end
