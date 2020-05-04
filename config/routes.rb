Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about'
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end
end