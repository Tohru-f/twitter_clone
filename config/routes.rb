# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/index'
  # get 'users/show'
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  get '/users/sign_in', to: 'users/sessions#new'
  get '/users/sign_up', to: 'users/registrations#new'

  resources :users, only: %i[show edit update]

  resources :tweets do
    resources :favorites, only: %i[create destroy new]
    resources :comments, only: %i[new create show destroy edit]
    resources :retweets, only: %i[create destroy]
  end

  resources :tweets, only: %i[new create show]

  resources :comments, only: %i[new create show]

  get '/profile' => 'users#profile'

  resources :home, only: %i[index new create]

  mount LetterOpenerWeb::Engine, at: 'letter_opener' if Rails.env.development?

  # Defines the root path route ("/")
  # root "articles#index"
end
