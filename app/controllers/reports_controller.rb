class ReportsController < ApplicationController
  def index

    if params[:clear].present?
      render 'index'
    end


    if params[:generate].present?


      @first_date = params[:first_date]# Date.today.beginning_of_month
      @last_date = params[:last_date]
      if params[:first_date] == "" or params[:first_date] == ""
          @first_date = Date.today.beginning_of_month
          @last_date = Date.today.end_of_month 
      end
      @category_id = params[:category_id]




      if params[:type_graph].to_i == 1
        redirect_to reports_report_by_dates_path(category_id: params[:category_id], first_date: @first_date, last_date:@last_date, income:params[:income])
      else
        redirect_to reports_report_by_category_path(category_id: params[:category_id], first_date: @first_date, last_date:@last_date, income:params[:income])
      end



    end

  end

  def report_by_category
    #@operations = Operation.all
    #@categories = Category.all
    @user = User.find_by(id: session[:user_id])
    @cat_id = params[:category_id]
    @first_date = params[:first_date]
    @last_date = params[:last_date]
    @income = params[:income]


    @categories = @user.categories.where(:user_id == @user.id).group(:name).joins(:operations).where("operations.income == ? AND operations.odate BETWEEN ? AND ?", @income , @first_date, @last_date).sum(:amount)
    @sum = @user.categories.where(:user_id == @user.id).joins(:operations).where("operations.income == ? AND operations.odate BETWEEN ? AND ?", @income , @first_date, @last_date).sum(:amount)

  end

  def report_by_dates
    @user = User.find_by(id: session[:user_id])
    @cat_id = params[:category_id]
    @first_date = params[:first_date]
    @last_date = params[:last_date]
    @income = params[:income]


    
    @op_full_info = @user.operations.order("odate").where("category_id == ? AND income == ? AND odate >= ? AND odate <= ?", @cat_id, @income , @first_date, @last_date)
    
  end
end
