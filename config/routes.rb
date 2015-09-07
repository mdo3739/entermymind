Rails.application.routes.draw do
  get 'static/index'
  get 'static/contact'
  root to: 'static#index'
  
  devise_for :users
  resources :users, only: [:index]

  resources :posts, only: [] do
    resources :comments, except: [:index]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end
  resources :topics do
    resources :posts
  end
end
