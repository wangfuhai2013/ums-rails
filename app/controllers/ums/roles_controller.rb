class Ums::RolesController < ApplicationController
  before_action :set_ums_role, only: [:show, :edit, :update, :destroy]
  before_action :set_ums_functions, only: [:new,:edit,:update,:create]
  before_action :init_function_ids, only: [:create, :update]
  # GET /ums/roles
  # GET /ums/roles.json
  def index
    @ums_roles = Ums::Role.all
  end

  # GET /ums/roles/1
  # GET /ums/roles/1.json
  def show
  end

  # GET /ums/roles/new
  def new
    @ums_role = Ums::Role.new
  end

  # GET /ums/roles/1/edit
  def edit
  end

  # POST /ums/roles
  # POST /ums/roles.json
  def create
    @ums_role = Ums::Role.new(ums_role_params)

    respond_to do |format|
      if @ums_role.save
        format.html { redirect_to ums.roles_url, notice: '角色创建成功.' }
        format.json { render action: 'show', status: :created, location: @ums_role }
      else
        format.html { render action: 'new' , status: :unprocessable_entity}
        format.json { render json: @ums_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ums/roles/1
  # PATCH/PUT /ums/roles/1.json
  def update
    respond_to do |format|
      if @ums_role.update(ums_role_params)
        format.html { redirect_to ums.roles_url, notice: '角色修改成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' , status: :unprocessable_entity}
        format.json { render json: @ums_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ums/roles/1
  # DELETE /ums/roles/1.json
  def destroy
    if  Ums::User.find_by_role_id(@ums_role.id)
      flash[:error] = "该角色还有关联用户，不能删除"
    else
      @ums_role.destroy
    end
    respond_to do |format|
      format.html { redirect_to ums.roles_url , notice: '角色删除成功.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ums_role
      @ums_role = Ums::Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ums_role_params
      params.require(:role).permit(:name,{:function_ids => []})
    end
    def set_ums_functions
      @ums_functions = Ums::Function.all
    end

    def init_function_ids 
      params[:role][:function_ids] ||= [] 
    end
end
