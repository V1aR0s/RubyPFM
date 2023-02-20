

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




    #last operations rails for table
    @last_op = @user.operations.order("odate")
      .where(:odate => @current_month_first_day..@current_month_last_day).last(3).reverse





    op_full_info = @user.operations.order("odate").where("odate BETWEEN ? AND ?", @current_month_first_day, @current_month_last_day)

    #@op.unshift("start month" => 0)

    start_value = 0


    op_full_info.each do |op|
      if op.income == true
        start_value += op.amount
      else
        start_value -= op.amount
      end
      op.amount = start_value
    end

    @operation_graph = op_full_info.pluck(:odate, :amount)


  end
end
