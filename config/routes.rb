Rails.application.routes.draw do
  devise_for :users
  root "proposals#index"
  resources :proposals, only: [:index, :new, :create] do
    resources :executions, only: [:index, :new, :create] 
  end
end
