Rails.application.routes.draw do
  resources :topics
  root to: 'static#index'
  devise_for :users
  get 'static/index'

  get 'static/contact'
end
