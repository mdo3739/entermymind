Rails.application.routes.draw do
  root to: 'static#index'
  devise_for :users
  get 'static/index'

  get 'static/contact'

  get 'blog/index'

  get 'case_studies/index'

  

  
end
