class Ums::LogsController < ApplicationController

  # GET /ums/logs
  # GET /ums/logs.json
  def index
    @ums_logs = Ums::Log.all.page(params[:page]).order("id DESC")
  end

end
