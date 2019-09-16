# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    resources :bets
    resources :users

    post :autocomplete, to: 'autocomplete#search'
    post :auth,         to: 'user_token#create'
  end
end
