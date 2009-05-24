class Role < ActiveRecord::Base
	belongs_to :project
	belongs_to :user
	belongs_to :role_template
	validates_presence_of :title, :description, :project_id, :user_id, :role_template_id
end
