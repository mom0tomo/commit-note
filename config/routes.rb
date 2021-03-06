Rails.application.routes.draw do
  root to: 'tops#index'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  resources :users, only: [:new, :create] do
    resources :months, only: [:index, :show]

    get 'create', to: 'commits#create', as: :create_commit
    resources :commits, only: [:new, :create]
  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :sessions, only: [:new, :create, :destroy]
end
