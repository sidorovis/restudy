def gedel_impl( a , b )
	return b if a > b
	return 1
end
def impl(a,b)
	gedel_impl(a,b)
end
def minimum(a,b)
	return a if a < b
	b
end
def maximum(a,b)
	return a if a > b
	b
end

class Fact
	attr_reader :name, :attr_names, :attr_values
	def initialize(name, set)
		@name = name.to_s
		@attr_names = []
		@attr_values = {}
		for k,v in set
			@attr_names << k
			@attr_values[k] = v
		end
		@attr_names.sort! { |l,r| l.to_s<=>r.to_s }
	end
	def to_s
		res = ""
		@attr_names.each { |a_name| res += " ( "+@attr_values[a_name].to_s+" / "+a_name.to_s+" ) " }
		" #{name} { "+res.to_s+" } "
	end
	def ==(other)
		return false if @attr_names != other.attr_names
		@attr_names.each { |name| return false if @attr_values[ name ] != other.attr_values[ name ] }
		return true
	end
end


class Rule
	attr_reader :from, :to
	def initialize(from_name, to_name)
		@from = $facts.find { |fact| true if fact.name == from_name.to_s }
		@to = $facts.find { |fact| true if fact.name == to_name.to_s }
        if !@from || !@to
	       	puts "Not enought facts to rule: #{from_name} -> #{to_name}"
        	exit(1)
        end   
		makeMatrix
	end
	def makeMatrix
	    @m = Array2.new
	    i = 0
	    for from_name in @from.attr_names
	    	i += 1
	    	u = 0
	    	for to_name in @to.attr_names
	    		u += 1
	    		from_value, to_value = @from.attr_values[ from_name ], @to.attr_values[ to_name ]
	    		@m[ u , i ] = impl( from_value , to_value )
	    	end
	    end
	end
	def to_s
		res = "    "+@from.name.to_s+" -> "+@to.name.to_s+"\n"
		res += @m.to_s
	end
	def factFit?( fact )
		@from.attr_names == fact.attr_names
	end
	def generateFact( fact )
		attr_names = @to.attr_names.clone
		attr_values = {}
		for i in 1..@from.attr_names.size
#			print fact.attr_names[i-1],"   "
			max = 0
			for u in 1..@to.attr_names.size
#				print @m[i,u],"-min-",fact.attr_values[ fact.attr_names[u-1] ]," = ",minimum( @m[i,u] , fact.attr_values[ fact.attr_names[u-1] ] ),"  "
				max = maximum(max, minimum( @m[i,u] , fact.attr_values[ fact.attr_names[u-1] ] ) )
			end
#			puts max
			attr_values[ @to.attr_names[ i-1 ] ] = max
		end
		name = fact.name.to_s+"("+@from.name.to_s+"|"+@to.name.to_s+")"
		fact = Fact.new(name,attr_values)
	end
end