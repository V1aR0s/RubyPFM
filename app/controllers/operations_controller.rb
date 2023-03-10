class OperationsController < ApplicationController
  

  before_action :set_operation, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  
  # GET /operations or /operations.json
  def index
    # --- sort params ---
    #0 - category
    #1 - dates
    #2 - amount
    #t("tables.category"), t("tables.date"), t("tables.amount")
    @array_sort = { 0 => t("tables.category"), 1 =>  t("tables.date"), 2 => t("tables.amount") }
    

    if params[:sort_id].present?
      #vozrast
      s = params[:sort_id].to_i
      case s
      when 0      
        operations_sort = User.find_by(id:session[:user_id]).operations.joins(:category)
        .order(name: params[:type_sort].to_i == 1 ? :desc : :asc )
        #@s = s
      when 1
        operations_sort = User.find_by(id:session[:user_id]).operations.order(odate: params[:type_sort].to_i == 1 ? :desc : :asc)
        #@s = s
      when 2
        operations_sort = User.find_by(id:session[:user_id]).operations.order(amount:params[:type_sort].to_i == 1 ? :desc : :asc)
       # @s = s
      else
        operations_sort = User.find_by(id:session[:user_id]).operations.order(odate: :desc)
      end
    else
      operations_sort = User.find_by(id:session[:user_id]).operations.order(odate: :desc) 
    end
    @pagy, @operations = pagy(operations_sort, items: 10)

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
          format.html { redirect_to operations_url, notice: t("notions.operation_created") }
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
          format.html { redirect_to operations_url, notice: t("notions.operation_updated") }
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
        format.html { redirect_to operations_url, notice: t("notions.operation_deleted") }
        format.json { head :no_content }
      end
    else

    end


  end



  def graphic
    
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
