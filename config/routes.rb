QuantifiedLife::Application.routes.draw do
  devise_for :users
  resources :posts
  resources :photos

  resources :days, only: [:index, :show, :edit, :update, :new, :create]

  root to: "home#index"
end
