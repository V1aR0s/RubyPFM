class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:name, :surname, :email)

    User.create(user_params)


    redirect_to root_path, notice: "Вы успешона зарегестрировались!"
  end
end
