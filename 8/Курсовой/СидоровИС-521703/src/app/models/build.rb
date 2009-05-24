class Build < ActiveRecord::Base
	belongs_to :build_status
	belongs_to :project
	has_many :bugs, :dependent => :destroy
	validates_presence_of :title, :description, :project_id, :build_status_id
end
