QuantifiedLife::Application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
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

  root to: "home#index"
end
