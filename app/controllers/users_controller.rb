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
    @user.current_amount = 0.0

    if @user.save


      redirect_to root_path, notice: t("notions.user_register")


    else
      flash.now[:alert] = t("notions.incorrect_reg")

      render :new
    end

  end
end
