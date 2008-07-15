#=begin
class Fixnum
	include Enumerable
	def each(&block)
		(1..self).each(&block)
	end
	def to_str
		to_s
	end

end
#=end
5.each {|i| puts "Hi " + i }
