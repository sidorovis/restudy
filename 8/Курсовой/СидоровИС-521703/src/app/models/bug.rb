class Bug < ActiveRecord::Base
	belongs_to :bug_status
	belongs_to :build
	belongs_to :project
	validates_presence_of :title, :description, :build_id, :bug_status_id
end
