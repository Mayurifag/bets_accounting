# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    resources :bets
    resources :users, param: :_username
  end

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
