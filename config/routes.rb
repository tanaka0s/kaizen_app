Rails.application.routes.draw do
  devise_for :users
  root "proposals#index"
  resources :proposals, only: [:index, :new, :create, :edit, :update] do
    resources :executions, only: [:new, :create] 
  end
  resources :executions, only: :index
  resources :executions, only: [:edit, :update]
end
