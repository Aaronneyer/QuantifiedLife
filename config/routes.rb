QuantifiedLife::Application.routes.draw do
  devise_for :users
  resources :posts
  resources :photos do
    collection do
      get :batch_upload
      post :multi_create
    end
  end

  resources :days, only: [:index, :show, :edit, :update, :new, :create]

  resources :auth, only: :none do
    collection do
      get :github
      get :github_callback
    end
  end

  root to: "home#index"
end
