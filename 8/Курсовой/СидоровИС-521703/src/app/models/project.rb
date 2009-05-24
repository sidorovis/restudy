class Project < ActiveRecord::Base
	belongs_to :project_status
	has_many :roles, :dependent => :destroy
	has_many :users, :through => :roles
	has_many :tasks, :dependent => :destroy
	has_many :issues, :dependent => :destroy
	has_many :builds, :dependent => :destroy
	has_many :bugs, :through => :builds
	validates_presence_of :title, :description
end
