Rails.application.routes.draw do
  resources :posts, only: [] do
    resources :comments
  end
  resources :topics do
    resources :posts
  end
  root to: 'static#index'
  devise_for :users
  get 'static/index'

  get 'static/contact'
end
