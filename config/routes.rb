Rails.application.routes.draw do

  root "pieces#index"

  devise_for :users
  # devise_for :users

  resources :users, only: :index
  resource :profile
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'pieces/owned' => 'pieces#owned', as: :pieces_owned
  get 'pieces' => 'pieces#index', as: :pieces_all
  get "pieces/:id/edit" => "pieces#edit", as: :edit_piece
  get 'pieces/new/' => 'pieces#new', as: :new_piece
  get 'pieces/:id' => 'pieces#show', as: :piece
  post 'pieces' => 'pieces#create'
  patch 'pieces/:id' => 'pieces#update'
  delete 'pieces/:id' => 'pieces#destroy'

  get 'deals/new' => 'deals#new', as: :new_deal
  post 'deals' => 'deals#create'
  get 'deals/:id' => 'deals#show', as: :deal
  patch 'deals/:id' => 'deals#update'
  delete 'deals/:id' => 'deals#destroy'

end
