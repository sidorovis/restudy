class BuildStatus < ActiveRecord::Base
	has_many :builds, :dependent => :destroy
	validates_presence_of :title, :description

end
