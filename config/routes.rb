Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root 'main#index'

    get '/indexlog', to: 'main#MainPage'
    get 'reports/index'
    get 'reports/report_by_category'
    get 'reports/report_by_dates'
    get 'main/index'
    get 'operations/graphic'
    #post  'locales/:locale', to: 'locales#set_locale', as: :set_locale
  
    resources :operations
    #resources :locale
    resources :categories
    resource :session, only: %i[new create destroy]
    resources :users, only: %i[new create]
  
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
    # Defines the root path route ("/")
    # root "articles#index"  
  end
  
end
