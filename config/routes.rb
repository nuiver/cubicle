Rails.application.routes.draw do
  # devise_for :users

  resources :users, only: :index
  resource :profile, only: [:show, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
