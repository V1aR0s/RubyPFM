class MainController < ApplicationController
  def index
    if current_user
      redirect_to controller: :main, action: :MainPage
    end

  end

  def MainPage
    if !current_user
      redirect_to root_path
    end

    @user = User.find_by(id: session[:user_id])


    @current_month_today = Date.today
    @current_month_first_day = Date.today.beginning_of_month
    @current_month_last_day = Date.today.end_of_month

    @last_op = @user.operations.limit(5).order("odate")
      .where(:odate => @current_month_first_day..@current_month_last_day).reverse



  end
end
