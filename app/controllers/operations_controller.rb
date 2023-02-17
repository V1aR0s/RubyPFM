class OperationsController < ApplicationController
  

  before_action :set_operation, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  
  # GET /operations or /operations.json
  def index
    #@operations = User.find_by(id:session[:user_id]).operations
    @pagy, @operations = pagy(User.find_by(id:session[:user_id]).operations, items: 10)

  end

  # GET /operations/1 or /operations/1.json
  def show
  end

  # GET /operations/new
  def new
    @operation = Operation.new





  end

  # GET /operations/1/edit
  def edit
  end

  # POST /operations or /operations.json
  def create
    @operation = Operation.new(operation_params)
    @operation.user_id = session[:user_id]
    respond_to do |format|
      if @operation.save
        us = User.find_by(id:session[:user_id])
        if @operation.income
          us.current_amount += @operation.amount
        else
          us.current_amount -= @operation.amount
        end
        if us.save
          format.html { redirect_to operation_url(@operation), notice: "Операция была создана." }
          format.json { render :show, status: :created, location: @operation }
        end
      end
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @operation.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /operations/1 or /operations/1.json
  def update
    respond_to do |format|

      us = User.find_by(id:session[:user_id])
      if @operation.income
        us.current_amount -= @operation.amount
      else
        us.current_amount += @operation.amount
      end

      if @operation.update(operation_params)
        if @operation.income
          us.current_amount += @operation.amount
        else
          us.current_amount -= @operation.amount
        end
        if us.save
          format.html { redirect_to operation_url(@operation), notice: "Операция была обновлена." }
          format.json { render :show, status: :created, location: @operation }
        end
      end

      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @operation.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /operations/1 or /operations/1.json
  def destroy

    us = User.find_by(id:session[:user_id])
    if @operation.income
      us.current_amount -= @operation.amount
    else
      us.current_amount += @operation.amount
    end

    if us.save
      @operation.destroy

      respond_to do |format|
        format.html { redirect_to operations_url, notice: "Операция была удалена." }
        format.json { head :no_content }
      end
    else

    end


  end



  def graphic
    
    @user = User.find_by(id: session[:user_id])

    @first_day = Date.today.beginning_of_month
    @last_dat = Date.today.end_of_month

    operations_before =  @user.operations.order("odate").where(:odate => @first_day..@last_dat)
    start_value = 0

    operations_before.each do |op|
      if op.income == true
        start_value += op.amount
      else
        start_value -= op.amount
      end
      op.amount = start_value
    end
    
    @operations = operations_before.pluck(:odate, :amount)
    
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation
      @operation = Operation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def operation_params
      params.require(:operation).permit(:amount, :odate, :description, :category_id, :income)
    end


end
