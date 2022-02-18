class Ums::FunctionsController < ApplicationController
  before_action :set_ums_function, only: [:show, :edit, :update, :destroy]

  # GET /ums/functions
  # GET /ums/functions.json
  def index
    @ums_functions = Ums::Function.all
  end

  # GET /ums/functions/1
  # GET /ums/functions/1.json
  def show
  end

  # GET /ums/functions/new
  def new
    @ums_function = Ums::Function.new
  end

  # GET /ums/functions/1/edit
  def edit
  end

  # POST /ums/functions
  # POST /ums/functions.json
  def create
    @ums_function = Ums::Function.new(ums_function_params)

    respond_to do |format|
      if @ums_function.save
        format.html { redirect_to ums.functions_url, notice: '功能创建创建成功.' }
        format.json { render action: 'show', status: :created, location: @ums_function }
      else
        format.html { render action: 'new' , status: :unprocessable_entity}
        format.json { render json: @ums_function.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ums/functions/1
  # PATCH/PUT /ums/functions/1.json
  def update
    respond_to do |format|
      if @ums_function.update(ums_function_params)
        format.html { redirect_to ums.functions_url, notice: '功能修改成功' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' , status: :unprocessable_entity}
        format.json { render json: @ums_function.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ums/functions/1
  # DELETE /ums/functions/1.json
  def destroy
    @ums_function.destroy
    respond_to do |format|
      format.html { redirect_to ums.functions_url , notice: '功能删除成功.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ums_function
      @ums_function = Ums::Function.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ums_function_params
      params.require(:function).permit(:name, :controller, :action)
    end
end
