Rails.application.routes.draw do
  devise_for :users
  resources :products, only: [:index, :show] do
    resources :investments, only: [:index, :new, :create]
  end

  namespace :admin do
    resources :products
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
