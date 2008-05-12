require "3.rb"
class B < A
	attr_accessor :z
	include Comparable
	def to_s
		super + " hello"
	end
	def <=>(objB)
		@z<=> objB.z
	end
end

a = A.new(3)
b = B.new(4)
b2 = B.new(5)
# a.z = 5
b.z = 4
b2.z = 6
puts a,b
puts b2 < b

