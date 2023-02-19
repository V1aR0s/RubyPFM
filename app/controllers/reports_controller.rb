class ReportsController < ApplicationController
  def index

    if params[:clear].present?
      render 'index'
      puts("""""""""""")
    end
    
    @category_id = params[:category_id]
    redirect_to reports_report_by_category_path(category_id: params[:category_id])
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
