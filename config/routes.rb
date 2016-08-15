Rails.application.routes.draw do

  root "pieces#index"

  devise_for :users
  # devise_for :users

  resources :users, only: :index
  resource :profile, only: [:show, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'pieces' => 'pieces#index'
  get "pieces/:id/edit" => "pieces#edit", as: :edit_piece

  get 'pieces/new' => 'pieces#new', as: :new_piece
  get 'pieces/:id' => 'pieces#show', as: :piece
  post 'pieces' => 'pieces#create'
end
