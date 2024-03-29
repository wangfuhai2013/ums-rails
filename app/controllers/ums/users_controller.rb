class Ums::UsersController < ApplicationController

  skip_before_action :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  skip_before_action :authorize, :only => [:login,:logout]

  before_action :set_ums_user, only: [:show, :edit, :update, :destroy]
  before_action :set_ums_roles, only: [:new,:edit,:update,:create]
  # GET /ums/users
  # GET /ums/users.json

  def welcome    
  end

  def login
    if request.post?
      user = Ums::User.authenticate(params[:account],params[:password])
      if user 
        login_count = user.login_count      
        login_count = 0 if login_count.nil?
        login_count += 1
        
        session[:last_login_time] = user.last_login_time
        session[:last_login_ip] = user.last_login_ip
        session[:login_count] = login_count

        user.last_login_time = Time.now
        user.last_login_ip = request.remote_ip
        user.login_count = login_count
        user.save(validate: false)

        session[:user_id] = user.id
        session[:user_account] = user.account
        session[:user_name] = user.name

        uri = session[:original_uri]
        session[:original_uri] = nil
        log_info("login",params[:account] + "登录成功")

        user_permission = '^redactor_rails|welcome|profile|password|' # 上传组件和用户基础操作默认许可
        user.role.functions.each do |function| 
          if function.action.blank?
            user_permission += '^' + function.controller
          else
            user_permission += function.controller + "/" + function.action
          end          
          user_permission += "|"
        end

        user_permission.chop! unless user_permission.blank?
        session[:user_permission] = user_permission

        respond_to do |format|
          format.html { redirect_to  uri || root_path }
          format.json { render json: {is_success:"true",message:"登录成功",user:user} }
        end

      else
        log_error("login",params[:account] + "登录失败")
        respond_to do |format|
          error_info = "无效的账号或密码"
          format.html { flash.now[:notice] = error_info }
          format.json { render json: {is_success:"false",message:error_info} }
        end
        
      end
    end
  end

  def logout
    log_info("logout",session[:user_account].to_s + "退出登录")
    session[:user_id] = nil
    session[:user_account] = nil
    session[:user_name] = nil
    session[:last_login_time] = nil
    session[:last_login_ip] = nil
    session[:login_count] = nil
    #flash[:notice] = "已退出"
    redirect_to  root_path 
  end

  def password
    if request.post?
      if params[:new_password].blank?
        flash.now[:error] = "新密码不能为空"
        return
      end
      if params[:new_password] != params[:re_password]
        flash.now[:error] = "两次新密码输入不一致"
        return
      end
      if params[:new_password].blank?
        flash.now[:error] = "新密码不能为空"
        return
      end
      user = Ums::User.find_by_id(session[:user_id])      
      if user.verify_password(params[:old_password])
        user.password=params[:new_password]
        if user.save
          flash.now[:notice] = "密码修改成功"
          params.delete(:new_password)
          params.delete(:old_password)
          params.delete(:re_password)
        else
          flash.now[:error] = user.errors.full_messages.to_s
        end
      else 
        flash.now[:error] = "旧密码输入错误"
      end
      render status: :unprocessable_entity   
    end
  end

  def profile
    @ums_user = Ums::User.find_by_id(session[:user_id])
    if request.patch?
       if @ums_user.update(params.require(:user).permit(:email))
         flash.now[:notice] = "资料修改成功"
       else
         flash.now[:error] = "资料修改失败"       
       end
       render status: :unprocessable_entity 
    end
  end

  def index
    @ums_users = Ums::User.all
  end
  def show
  end
  # GET /ums/users/new
  def new
    @ums_user = Ums::User.new
    @ums_user.is_enabled = true
  end

  # GET /ums/users/1/edit
  def edit
  end

  # POST /ums/users
  # POST /ums/users.json
  def create
    @ums_user = Ums::User.new(ums_user_params)

    respond_to do |format|
      if @ums_user.save
        format.html { redirect_to ums.users_url, notice: '用户创建成功.' }
        format.json { render action: 'show', status: :created, location: @ums_user }
      else
        format.html { render action: 'new' , status: :unprocessable_entity }
        format.json { render json: @ums_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ums/users/1
  # PATCH/PUT /ums/users/1.json
  def update
    respond_to do |format|
      if @ums_user.update(ums_user_params)
        format.html { redirect_to ums.users_url, notice: '用户修改成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit', status: :unprocessable_entity  }
        format.json { render json: @ums_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ums/users/1
  # DELETE /ums/users/1.json
  def destroy
    @ums_user.destroy
    respond_to do |format|
      format.html { redirect_to ums.users_url, notice: '用户删除成功.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ums_user
      @ums_user = Ums::User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ums_user_params
      params.require(:user).permit(:account, :name,:email, :password, :role_id, :is_enabled)
    end

    def set_ums_roles
      @ums_roles = Ums::Role.all
    end
end
