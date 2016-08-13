Rails.application.routes.draw do


  devise_for :users
  # devise_for :users

  resources :users, only: :index
  resource :profile, only: [:show, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'pieces' => 'pieces#index'
  get 'pieces/:id' => 'pieces#show', as: :piece
  get 'pieces/new' => 'pieces#new', as: :new_piece
  post 'pieces' => 'pieces#create'
end
