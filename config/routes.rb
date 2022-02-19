Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :products
  namespace :admin do
    resources :employees do
      post :activate, on: :member
    end
  end
  root to: 'home#index'
end
