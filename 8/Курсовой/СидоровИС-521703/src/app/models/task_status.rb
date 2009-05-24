class TaskStatus < ActiveRecord::Base
	has_many :tasks, :dependent => :destroy
	validates_presence_of :title, :description
end
