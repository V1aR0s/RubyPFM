class SessionsController < ApplicationController
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

      redirect_to root_path, notice: "вы вошли на сайт"
    
    else
        flash.now[:alert] = "Неправильная почта или пароль"

        render :new
     end
  end


  def destroy
    session.delete(:user_id)

    redirect_to root_path, notice: "Выход успешен"
  end

end
