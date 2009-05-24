class BugStatus < ActiveRecord::Base
	has_many :bugs, :dependent => :destroy
	validates_presence_of :title, :description
end
