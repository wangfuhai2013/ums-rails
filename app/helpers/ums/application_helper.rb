module Ums
  module ApplicationHelper

    #为ActiveRecord类设置session变量
    def set_current_session
      # Define an accessor. The session is always in the current controller
      # instance in @_request.session. So we need a way to access this in
      # our model
      accessor = instance_variable_get(:@_request)

      # This defines a method session in ActiveRecord::Base. If your model
      # inherits from another Base Class (when using MongoMapper or similar),
      # insert the class here.
      ActiveRecord::Base.send(:define_method, "session", proc {accessor.session})
    end

    #操作日志，主要针对model的增删改
    def operate_log    
       log = Ums::Log.new
       log.level="info"
       log.log_type= action_name
       log.ip= request.remote_ip       
       log.operator = session[:user_account] unless session[:user_account].blank?
       model_class = self.class.name.sub("Controller", "")
       #logger.debug("model_class:"+ model_class)
       log.model_class = model_class
       model_var_name = model_class.singularize.sub("::", "_").downcase
       model_var = instance_variable_get("@"+model_var_name)
       if model_var && model_var.kind_of?(ActiveRecord::Base)
         log.model_id = model_var.id
         log.data = ""
         log.data = model_var.name if model_var.has_attribute?(:name)
         log.data = model_var.title if model_var.has_attribute?(:title)
         if !model_var.errors.blank?
           log.level="error" 
           log.data += model_var.errors.full_messages.to_s
         end
       end
       log.save
    end

    #用户访问权限检查
    def authorize
      #unless Account.find_by_id(session[:account_id])
      if session[:user_id].nil?
        session[:original_uri] = request.url
        #flash[:notice] = "Please log in"
        redirect_to  ums.users_login_url 
        return    
      end

      path = params[:controller] + "/" + params[:action]
      unless validate_permission(path)
         render status: :forbidden, text: "对不起，您没有访问该地址的权限"
      end    
    end
    
    #根据访问路径判断访问权限
    def validate_permission(path)
      permission = session[:user_permission]

      logger.debug("user_permission:" + permission) unless permission.nil?
      logger.debug("user_path:" + path) unless path.nil?
      return false if permission.nil? || path.nil?
      is_validated = path.match(permission)
      is_validated = (path + "/index").match(permission) unless is_validated #增加模块默认地址检测
      return is_validated
    end

    #记录信息日志
    def log_info(log_type,log_content)
      log = Ums::Log.new
      log.level="info"
      log.log_type=log_type
      log.data=log_content
      log.ip=request.remote_ip
      log.operator = session[:user_account] unless session[:user_account].blank?
      log.save
    end

    #记录错误日志
    def log_error(log_type,log_content)
      log = Ums::Log.new
      log.level="error"
      log.log_type=log_type
      log.data=log_content
      log.ip=request.remote_ip
      log.operator = session[:user_account] unless session[:user_account].blank?
      log.save
    end

  end
end
