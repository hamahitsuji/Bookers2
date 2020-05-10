Rails.application.routes.draw do
  get 'chats/show'
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

  resources :rooms, only: [:create] do
    resource :chats, only: [:create, :show]
  end

end
