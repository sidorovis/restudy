# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

	include AuthenticatedSystem

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :login_required
  before_filter :projects_required
  
  def projects_required
	right_test
	@projects = []
	for role in current_user.roles
		@projects << role.project unless @projects.include? role.project
	end
  end
  
  def right_test_for_role_template( role_template )
	for right in role_template.right_templates
	  if right.controller == controller_name
		return role_template.title+" "+right.actions+" "+right.write_ids+" "+right.read_ids
	  end
	end
	"NONE"
  end
  def right_test
	puts current_user.login
	have_right = false
	current_user.roles.each { |r| puts right_test_for_role_template( r.role_template ) }
	puts controller_name, action_name
	
#	redirect_to_dashboard( 'У вас не достаточно прав для этого действия' )
  end
  
  def redirect_to_dashboard( reason )
	flash[:error] = reason
	redirect_back_or_default('/')
  end
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
