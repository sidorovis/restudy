#!/usr/bin/ruby

require "input"

# где a v b Ц min(a,b); 
#     a ^ b Ц max(a,b).

class Uravnenie
	attr_reader :koeficients, :result
	def initialize()
		@koeficients = []
		@result = 0
	end
	def addK( k )
		@koeficients.push k
	end
	def setR( r )
		@result = r
	end
	def to_s
		t = []
		(0..@koeficients.size-1).each { |i| t.push "( x"+i.to_s+" ^ "+@koeficients[i].to_s+" )" }
		t.join(" v ").to_s + " = " + @result.to_s
	end
end
bd = []
koef_kol = 0
for uravnenie in $s
	u = Uravnenie.new 
	uravnenie[0].each { |aiu| u.addK aiu }
	koef_kol = uravnenie[0].size if koef_kol < uravnenie[0].size
	u.setR uravnenie[1]
	bd.push u
end
answers = Array.new(koef_kol,[-2147483647,2147483647])
puts bd.join("\n")
puts "answers.size: #{answers.size} "