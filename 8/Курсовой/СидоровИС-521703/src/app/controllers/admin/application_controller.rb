# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
module Admin
class ApplicationController < ActionController::Base

	include AuthenticatedSystem

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :login_required
  before_filter :test_root
  before_filter :projects_required
  
  def projects_required
	@projects = []
	for role in current_user.roles
		@projects << role.project unless @projects.include? role.project
	end
  end
  def test_root
	if current_user.login != 'root'
		flash[:error] = "У вас нет прав администратора"
		redirect_to(:dashboard)
	end
  end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
end