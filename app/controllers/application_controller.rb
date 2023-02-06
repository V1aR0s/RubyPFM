class ApplicationController < ActionController::Base
    helper_method :current_user
    private

    def current_user
        #если переменная пустая то выолнит действие если, нет то не будет выполнять действие после равно
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
end
