# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    resources :bets
    post :autocomplete, to: 'autocomplete#search'
    post 'auth' => 'user_token#create'
    get    'users'          => 'users#index'
    get    'users/whoami'   => 'users#whoami'
    post   'users/create'   => 'users#create'
    patch  'user/:id'       => 'users#update'
    delete 'user/:id'       => 'users#destroy'
  end
end
