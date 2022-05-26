# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  # login, logout
  get     'login'    => 'sessions#new'
  post    'login'    => 'sessions#create'
  delete  'logout'   => 'sessions#destroy'

  resources :users, only: %i[index new create]

  scope :ml_backend do
    get '/', to: 'home#index'

    # User's APIs
    namespace :api do
      namespace :v1 do
        resources :movies, only: %i[index show]
        resources :favorites, only: %i[index create]
      end
    end
  end
end
