class RightTemplate < ActiveRecord::Base
	belongs_to :role_template
	validates_presence_of :title, :description, :role_template_id
end
