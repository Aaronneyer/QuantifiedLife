QuantifiedLife::Application.routes.draw do
  require 'sidekiq/web'
  constraints Clearance::Constraints::SignedIn.new { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  resources :posts

  resources :photos do
    collection do
      get :batch_upload
      post :multi_create
    end
  end

  resources :days, only: [:index, :show, :edit, :update, :new, :create] do
    member do
      get :fetch_moves
    end
    collection do
      get :export
    end
  end

  resources :users, only: [:index, :show, :edit, :update]

  resources :github, only: [:index] do
    collection do
      get :backfill
    end
  end

  get '/auth/dropbox/callback' => 'callback#dropbox'
  get '/auth/github/callback' => 'callback#github'
  get '/auth/moves/callback' => 'callback#moves'

  root to: "home#index"
  get '/status' => 'home#status'
  get '/photos/image/:id' => 'photos#image', constraints: { id: /.+/ }
end
