QuantifiedLife::Application.routes.draw do
  require 'sidekiq/web'
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  devise_for :users
  resources :posts
  resources :photos do
    collection do
      get :batch_upload
      post :multi_create
    end
  end

  resources :days, only: [:index, :show, :edit, :update, :new, :create]

  resources :github, only: [:index, :new] do
    collection do
      get :callback
      get :backfill
    end
  end

  resources :dropbox, only: [:index, :new] do
    collection do
      get :callback
    end
  end

  resources :moves, only: [:index, :new] do
    collection do
      get :callback
    end
  end

  root to: "home#index"
end
