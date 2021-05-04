Rails.application.routes.draw do
  get 'cards/new'
  get 'items/search'
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :purchases, only: [:index, :create]
    resources :comments, only: [:create]
  end
  resources :cards, only: [:new, :create]
end
