class StringVariable < ActiveRecord::Base
	has_many :rules, :dependent => :destroy
	validates_presence_of :value
	def to_s
		title+"("+value+")"
	end
end
