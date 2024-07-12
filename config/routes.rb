# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/index'
  # get 'users/show'
  devise_for :users
  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: "home#index"

  get '/users/sign_in', to: 'users/sessions#new'
  get '/users/sign_up', to: 'users/registrations#new'

  resources :users, only: :show

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "letter_opener"
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
