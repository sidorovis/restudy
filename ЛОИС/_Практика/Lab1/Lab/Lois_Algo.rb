$stack = Array.new

class Fact
	def ===(target)
		puts "!!!_",target.name,target.params
		return true if @name == target.name && @params.size == target.params.size
		false
	end
end

def go_to( target )
	for i in $facts
		puts "!!! #{i}"
		if i === target
			return i
		end
	end
	nil
end

def look_for( target )
	puts "Looking answer for: \n\t#{target}"
	puts
	
	answer = go_to( target )
	puts "Answer is: \n\t #{answer}";
end