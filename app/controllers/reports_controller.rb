class ReportsController < ApplicationController
  def index


    
  end

  def report_by_category
    @operations = Operation.all
    @categories = Category.all
  end

  def report_by_dates
    @operations = Operation.all
    @categories = Category.all
  end
end
