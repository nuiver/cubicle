Rails.application.routes.draw do

  root "pieces#index"
  devise_for :users
  # devise_for :users

  # resources :users, only: :index
  resources :profiles
  resources :hearts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'pieces/owned' => 'pieces#owned', as: :pieces_owned
  get 'pieces/hearted' => 'pieces#hearted', as: :pieces_hearted
  get 'pieces/get_subtype' => 'pieces#get_subtype'
  get 'pieces/type/:product_type' => 'pieces#type', as: :pieces_type

  get 'pieces/:id/own' => 'pieces#own', as: :piece_own
  get 'pieces' => 'pieces#index', as: :pieces_all
  get "pieces/:id/edit" => "pieces#edit", as: :edit_piece
  get 'pieces/new/' => 'pieces#new', as: :new_piece
  get 'pieces/:id' => 'pieces#show', as: :piece
  post 'pieces' => 'pieces#create'
  patch 'pieces/:id' => 'pieces#update'
  delete 'pieces/:id' => 'pieces#destroy'

  get 'deals/new/:piece_id' => 'deals#new', as: :new_deal
  get 'deals' => 'deals#index', as: :deals
  get "deals/owner/" => 'deals#ownerindex', as: :owned_deals
  get 'deals/owner/:id' => 'deals#ownershow', as: :owned_deal
  get 'deals/owner/:id/edit' => 'deals#owneredit', as: :edit_owned_deal

  post 'deals' => 'deals#create'
  post 'deals/owner/' => 'deals#create'

  get 'deals/:id' => 'deals#show', as: :deal
  patch 'deals/:id' => 'deals#update'
  delete 'deals/:id' => 'deals#destroy'

end
