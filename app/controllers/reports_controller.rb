class ReportsController < ApplicationController
  def index

    if params[:clear].present?
      render 'index'
    end


    if params[:generate].present?


      @first_date = params[:first_date]# Date.today.beginning_of_month
      @last_date = params[:last_date]
      if params[:first_date] == nil || params[:first_date]
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
    @cat_id = params[:category_id]
  end

  def report_by_dates
    @operations = Operation.all
    @categories = Category.all
  end
end
