Rails.application.routes.draw do
  get 'static/index'
  get 'static/contact'
  root to: 'static#index'
  
  devise_for :users
  resources :users, only: [:index, :show]

  resources :posts, only: [:index] do
    resources :comments, except: [:index]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end
  resources :topics do
    resources :posts, except: [:index]
  end
end
