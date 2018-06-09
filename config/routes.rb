Rails.application.routes.draw do
  scope :api do
    resources :bets
  end

  get '*unmatched_route', to: 'pages#index'
  root to: 'pages#index'
end
