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

  root to: "home#index"
end
