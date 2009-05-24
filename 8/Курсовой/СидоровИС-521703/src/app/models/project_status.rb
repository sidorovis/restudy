class ProjectStatus < ActiveRecord::Base
	has_many :projects, :dependent => :destroy
	validates_presence_of :title, :description
end
