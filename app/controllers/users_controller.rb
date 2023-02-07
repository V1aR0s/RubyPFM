class UsersController < ApplicationController
  #controller for register user
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(
      :name, :surname, :email, :password, :password_confirmation
    )

    @user = User.new(user_params)

    
    if @user.save


      redirect_to root_path, notice: "Вы успешона зарегестрировались"

      
    else
      flash.now[:alert] = "Вы неправильно заполнили поля формы регистрации"

      render :new
    end

  end
end
