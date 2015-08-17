Rails.application.routes.draw do
  get 'static/index'

  get 'static/contact'

  get 'blog/index'

  get 'case_studies/index'

  root to: 'static#index'

  
end
