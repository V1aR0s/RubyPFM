Rails.application.routes.draw do
  root 'main#index'

  get 'reports/index'
  get 'reports/report_by_category'
  get 'reports/report_by_dates'
  get 'main/index'
 
  resources :operations
  resources :categories
  resource :session, only: %i[new create destroy]  
  resources :users, only: %i[new create]



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
