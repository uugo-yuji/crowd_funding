Rails.application.routes.draw do
  resources :investments, only: [:index, :new, :create]
  devise_for :users
  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
