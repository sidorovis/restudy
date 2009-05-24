class Task < ActiveRecord::Base
	belongs_to :task_status
	belongs_to :project
	validates_presence_of :title, :description, :task_status_id, :project_id
end
