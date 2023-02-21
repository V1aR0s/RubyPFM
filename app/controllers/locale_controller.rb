class LocaleController < ApplicationController
    def set
        if I18n.available_locales.include?(params[:locale].to_sym)
            I18n.locale = params[:locale]
            cookies.permanent[:locale] = params[:locale]
        end
      
        redirect_back(fallback_location: root_path)
    end
end