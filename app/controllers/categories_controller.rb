class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /categories or /categories.json
  def index
    if params[:serch_name].present?
      @serach_name = params[:serch_name]   
      
      @categories = User.find_by(id:session[:user_id]).categories.where('name LIKE ?', "%#{ @serach_name }%")
    else
      @categories = User.find_by(id:session[:user_id]).categories
    end

  end

  # GET /categories/1 or /categories/1.json
  def show
    # --- sort params ---
    #0 - category
    #1 - dates
    #2 - amount
    #t("tables.category"), t("tables.date"), t("tables.amount")
    @array_sort = { 0 => t("tables.category"), 1 =>  t("tables.date"), 2 => t("tables.amount") }
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
        operations_sort = User.find_by(id:session[:user_id]).operations.where("category_id Like ?",  params[:id]).joins(:category)
        .order(name: params[:type_sort].to_i == 1 ? :desc : :asc )
        #@s = s
      when 1
        operations_sort = User.find_by(id:session[:user_id]).operations.where("category_id Like ?",  params[:id]).order(odate: params[:type_sort].to_i == 1 ? :desc : :asc)
        #@s = s
      when 2
        operations_sort = User.find_by(id:session[:user_id]).operations.where("category_id Like ?",  params[:id]).order(amount:params[:type_sort].to_i == 1 ? :desc : :asc)
       # @s = s
      else
        operations_sort = User.find_by(id:session[:user_id]).operations.where("category_id Like ?",  params[:id]).order(odate: :desc)
      end
    else
      operations_sort = User.find_by(id:session[:user_id]).operations.where("category_id Like ?",  params[:id]).order(odate: :desc) 
    end
    @pagy, @operations = pagy(operations_sort, items: 10)
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create

    @category = Category.new(category_params)
    @category.user_id = session[:user_id]

    respond_to do |format|
      if @category.save
        format.html { redirect_to category_url(@category), notice: t("notions.category_created") }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_url(@category), notice: t("notions.category_updated") }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: t("notions.category_deleted") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :description)
    end
end