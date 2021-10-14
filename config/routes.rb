# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'pages#index'

  resources :page_users, only: %i[index show] do
    resources :tasks do
      resources :tags, only: %i[create]
    end
  end

  resources :subjects, only: %i[index] do
    resources :tasks do
      resources :tags, only: %i[create]
    end
  end

end