Rails.application.routes.draw do

  root 'main#index'

    get '/indexlog', to: 'main#MainPage'
    get 'reports/index'
    get 'reports/report_by_category'
    get 'reports/report_by_dates'
    get 'main/index'
    get 'operations/graphic'
    #post  'locales/:locale', to: 'locales#set_locale', as: :set_locale
    get '/users', to: 'users#index'

    resources :operations
    #resources :locale
    resources :categories
    resource :session, only: %i[new create destroy]
    resources :users, only: %i[new create]
  
end
