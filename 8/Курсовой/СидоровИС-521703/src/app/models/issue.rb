class Issue < ActiveRecord::Base
	belongs_to :issue_status
	belongs_to :project
	validates_presence_of :title, :description, :project_id, :issue_status
end
