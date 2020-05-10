Rails.application.routes.draw do
  root 'home#top'
  get 'home/about'
  get 'search' => 'searches#search'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end
  end

  resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]

  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]

end
