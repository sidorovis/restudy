class RoleTemplate < ActiveRecord::Base
	has_many :right_templates, :dependent => :destroy
	has_many :roles, :dependent => :destroy
	validates_presence_of :title, :description

	def self.undeleted_ids
		[1,2,3]
	end
end
