class A
	attr_reader :z

	def initialize(z)
		@z = z			
	end
	def to_s
		"A class with : "+@z.to_s
	end
end

a = A.new 4 
puts a,a.z