Rails.application.routes.draw do
  post 'messages/send'
  get 'message_groups/index'
  get 'message_groups/show'
  post 'message_groups/create'
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
