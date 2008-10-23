$stack = Array.new

class String
	def my_eq(with)
		return true if with == "?"
		return true if self == with
		false
	end
end


class BDParser::Fact
	def ===(target)
		label = true
		if @name == target.name && @params.size == target.params.size
			(0..@params.size - 1).each { |i| label = false unless @params[i].my_eq target.params[i] }
		else 
			label=false
		end
		label
	end
end

def go_to( target )
	for i in $facts
		if i === target
			puts "Answer is: \n\t #{i}";
		end
	end
end

def look_for( target )
	puts "= BEGIN ==============================================================="
	puts "Looking answer for: \n\t#{target.to_s}"
	puts
	
	answer = go_to( target )
	puts "= END ================================================================="
end