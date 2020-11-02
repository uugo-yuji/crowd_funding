Rails.application.routes.draw do
  
  resources :message_groups, only: [:index, :show, :create] do
    resources :messages, only: [:destroy] do
      post :sent, on: :collection
    end
  end
  devise_for :users
  resources :products, only: [:index, :show] do
    resources :investments, only: [:index, :new, :create]
    resources :likes, only: [:create, :destroy]
  end

  namespace :admin do
    resources :products
  end

  namespace :administer do
    resources :investments, only: [:index]
    resources :categories
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
