class SessionsController < ApplicationController
  
  #controller for login
  def new
   
  end

  def create
    user_params = params.require(:session)
    
    #метод, &. выполняеться если предидущее не равно nil 
    user = User.find_by(email: user_params[:email])&.authenticate(user_params[:password])
    p = BCrypt::Password.new(user.password_digest)

    
    #debugger
    if user.present? 
      session[:user_id] = user.id

      redirect_to root_path, notice: t("notions.user_login")
    
    else
        flash.now[:alert] = t("notions.incorrect_login_or_password")

        render :new
     end
  end


  #destroy session, exit button
  def destroy
    session.delete(:user_id)

    redirect_to root_path, notice: t("notions.logout")
  end

end
