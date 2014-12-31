class Ums::LogsController < ApplicationController

  # GET /ums/logs
  # GET /ums/logs.json
  def index
  	where = "1"
  	where += " AND level = '#{params[:level]}'" unless params[:level].blank? 
    where += " AND log_type = '#{params[:log_type]}'" unless params[:log_type].blank?
    where += " AND operator = '#{params[:operator]}'" unless params[:operator].blank? 
    where += " AND model_class like '#{params[:model_class]}%'" unless params[:model_class].blank? 
    where += " AND model_id = #{params[:model_id]}" unless params[:model_id].blank? 
    where += " AND ip like '#{params[:ip]}%'" unless params[:ip].blank? 
    where += " AND created_at like '#{params[:created_at]}%'" unless params[:created_at].blank? 
    @ums_logs = Ums::Log.where(where).page(params[:page]).order("id DESC")
  end

end
