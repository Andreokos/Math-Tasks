# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  root 'pages#index'

  resources :page_users, only: %i[index show] do
    resources :tasks do
      resources :tags, only: %i[create]
      resources :comments, only: %i[create destroy] do
        resources :likes, only: [:create, :destroy]
      end
    end
  end

  resources :subjects, only: %i[index] do
    post 'find_tasks', to: 'tags#find_tasks'
    get 'find_tasks', to: 'tags#find_tasks'
    resources :tags, only: %i[show]
    resources :tasks do
      resources :tags, only: %i[create]
      resources :comments, only: %i[create destroy]
      resources :likes, only: [:create, :destroy]
    end
  end

end