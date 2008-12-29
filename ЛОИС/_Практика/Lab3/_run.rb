#!/usr/bin/ruby

require "input"

# где a v b Ц min(a,b); 
#     a ^ b Ц max(a,b).

$bd = []
def teston()
	for u in $bd
		label = false
		for i in u
			if i <= u.result
				label = true
			end
		end
		return false unless label
	end
	return true
end

def find()
	ans = Answer.new
	$stack = Array.new( $bd.size, false )
#	for u in 0..$bd.size-1
#		for i in 0..$bd.size-1
			place( 1 , 0 , ans.clone )
#		end
#	end
end
def place(u_i, e_i, ans)
	$stack[ u_i ] = true
	puts u_i.to_s+" "+e_i.to_s+" "+ans.to_s
	if $bd[u_i][e_i] <= $bd[u_i].result
		if ans.min( e_i ) <= $bd[u_i].result
			ans.set_min( e_i , $bd[u_i].result ) if $bd[u_i][e_i] != $bd[u_i].result
			ans.set_max( e_i , $bd[u_i].result )
			for i in 0..$bd[ u_i ].size-1
				if i != e_i
#					if $bd[ u_i ][ i ] < $bd[u_i].result
						ans.set_min( i , $bd[u_i].result )
#					end
				end
			end
			for u in 0..$bd.size-1
				unless $stack[ u ]
					for i in 0..$bd[ u ].size-1 
						place( u, i, ans.clone )
					end
				end
			end
			r = $stack.find { |i| i == false }
			if r == nil
#				puts u_i
#				puts e_i
#				puts $stack.join(',')
				puts "     -> "+ans.to_s
			end
		end
	end
	$stack[ u_i ] = false
end

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
	def each(&block)
		@koeficients.each {|i| block.call( i )}
	end
	def [](i)
		@koeficients[i]
	end
	def []=(i,o)
		@koeficients[i]=o
	end
	def size
		@koeficients.size
	end
end
class Answer
	attr_reader :a
	def initialize()
		@a = []
		$bd[0].size.times { @a << [ 0 , 100 ] }
	end
	def to_s
		res = ""
		@a.each { |i| res += " [ "+i.join(", ")+" ] " }
		res
	end
	def min(i)
		@a[i][0]
	end
	def max(i)
		@a[i][1]
	end
	def set_min(i,o)
		@a[i][0] = o
	end
	def set_max(i,o)
		@a[i][1] = o
	end
	def clone
		res = Answer.new
		for i in 0..@a.size-1
			res.a[i] = @a[i].clone
		end
		res
	end
end
koef_kol = 0
for uravnenie in $s
	u = Uravnenie.new 
	uravnenie[0].each { |aiu| u.addK aiu }
	koef_kol = uravnenie[0].size if koef_kol < uravnenie[0].size
	u.setR uravnenie[1]
	$bd << u
end
puts "BD"
puts $bd.join("\n")
unless teston()
	puts "System incorrect"
	exit(0)
else
	puts
	puts
	find()
end
def maximum(a,b)
	return a if a > b
	return b
end
def minimum(a,b)
	return a if a < b
	return b
end
