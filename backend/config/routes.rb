# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    resources :bets
    resources :users

    # TODO: move to REST
    # http://jeromedalbert.com/how-dhh-organizes-his-rails-controllers/
    # https://habr.com/ru/post/136461/
    post :autocomplete, to: 'autocomplete#search'
    post :auth,         to: 'user_token#create'
  end
end
