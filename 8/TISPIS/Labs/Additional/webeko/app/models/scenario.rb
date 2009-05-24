class Scenario < ActiveRecord::Base
	has_one :rule
	validates_presence_of :rule_id

	before_save :sort_id
	def sort_id
		sort ||= ((Scenario.maximum(:sort)?Scenario.maximum(:sort)+1:nil) || 0).to_s
		write_attribute(:sort,sort)
	end

end
