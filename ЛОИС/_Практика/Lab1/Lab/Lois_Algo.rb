require 'digest/md5'

$stack = Array.new

class String
	def my_eq(with)
		return true if with == "?"
		return true if with >= "A" && with <= "Z"
		return true if self == with
		false
	end
end

class BDParser::Fact
	def ===(target)
		label = true
		if @name ==  target.name && @params.size == target.params.size
			(0..@params.size - 1).each { |i| label = false unless @params[i].my_eq target.params[i] }
		else 
			label=false
		end
		label
	end
end

class BDParser::Equal
	def fit(target)
		return true if target.name == @left
		return true if target.name == @right			
	end
end

class RParser::Target
	attr_reader :eq_operation_stack
	alias :init :initialize
	alias :to_str :to_s
	def initialize(name, params)
		init(name, params)
		@eq_operation_stack = Array.new
		puts self
	end
	def to_s
		str = self.to_str
		str+= "; Eq. stack: "+@eq_operation_stack.join(", ") if @eq_operation_stack.size > 0
		str
	end
	def equal!( eq )
		if @name == eq.left
			@name = eq.right
		else
			@name = eq.left
		end
		@eq_operation_stack.push( eq.name );
		self
	end
end

def go_to( target )
	return if @www.include? ( Digest::MD5.hexdigest( target.to_s ) )
	@www.push( Digest::MD5.hexdigest( target.to_s ) )
	for i in $facts
		if i === target
			puts "Answer is: \n\t #{i}";
		end
	end
	for i in $equals
	   if (i.fit( target ) && !target.eq_operation_stack.include?(i.name) )
	   		go_to( target.equal!( i ) )
	   end
	end
end

def look_for( target )
	@www = Array.new 	# Where We Was dots on graph
	puts "= BEGIN ==============================================================="
	puts "Looking answer for: \n\t#{target.to_s}"
	puts
	
	answer = go_to( target )
	puts "= END ================================================================="
end
