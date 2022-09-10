Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  root "proposals#index"
  resources :proposals, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :executions, only: [:new, :create]
    resources :comments, only: :create
  end
  resources :executions, only: [:index, :edit, :update, :destroy]
end
