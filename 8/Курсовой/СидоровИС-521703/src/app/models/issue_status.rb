class IssueStatus < ActiveRecord::Base
	has_many :issues, :dependent => :destroy
	validates_presence_of :title, :description
end
