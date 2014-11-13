module Ums
  class ApplicationController < ActionController::Base

	  before_action :set_current_session
      after_action :operate_log
  end
end
