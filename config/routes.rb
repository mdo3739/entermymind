Rails.application.routes.draw do
  resources :friends
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
    post '/newest-first' => 'topics#newest_first', as: :newest_first
    post '/oldest-first' => 'topics#oldest_first', as: :oldest_first
    post '/a-z' => 'topics#a_to_z', as: :a_to_z
    post '/z-a' => 'topics#z_to_a', as: :z_to_a
    post '/highest-rank' => 'topics#highest_rank', as: :highest_rank
    post '/lowest-rank' => 'topics#lowest_rank', as: :lowest_rank
  end
end
