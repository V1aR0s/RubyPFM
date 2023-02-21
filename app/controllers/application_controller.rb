class ApplicationController < ActionController::Base
    include Pagy::Backend
    #before_action :set_locale
    before_action :switch_locale
    helper_method :current_user
    
    private
    def switch_locale(&action)
        locale = params[:locale] || I18n.default_locale
        I18n.locale = locale
    end

    def current_user
        #если переменная пустая то выолнит действие если, нет то не будет выполнять действие после равно
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def authenticate_user!
        if !current_user
            redirect_to controller: :sessions, action: :new
        end
      end
end
