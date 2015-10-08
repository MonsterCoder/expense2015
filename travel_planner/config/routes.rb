Rails.application.routes.draw do
  resources :users
  resource :auth, only: [:create, :destroy], controller: :auth
end
