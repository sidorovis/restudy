class Rule < ActiveRecord::Base
	belongs_to :string_variable
	belongs_to :integer_variable
	has_many :scenario, :dependent => :destroy
	validates_presence_of :title
	def validate
		if is_integer && !integer_variable_id
			errors.add("Please choose integer variable","");
		end
		if is_string && !string_variable_id
			errors.add("Please choose string variable","");
		end
	end
end
