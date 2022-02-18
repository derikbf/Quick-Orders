Rails.application.routes.draw do
  
  devise_for :users
  resources :categories
  resources :products
  root to: 'home#index'
end
