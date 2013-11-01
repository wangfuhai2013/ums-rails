module Ums
  module ApplicationHelper

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
         render status: :forbidden, text: "访问被拒绝"
      end    
   end

   def log_info(log_type,log_content,log_ip)
		log = Ums::Log.new
		log.level="info"
		log.log_type=log_type
		log.data=log_content
		log.ip=log_ip
		log.save
  end

  def log_error(log_type,log_content,log_ip)
		log = Ums::Log.new
		log.level="error"
		log.log_type=log_type
		log.data=log_content
		log.ip=log_ip
		log.save
  end

  def validate_permission(path)
    permission = session[:user_permission]

    logger.debug("user_permission:" + permission) unless permission.nil?
    logger.debug("user_path:" + path) unless path.nil?
    return false if permission.nil? || path.nil?
    return path.match(permission)
  end
  end
end
