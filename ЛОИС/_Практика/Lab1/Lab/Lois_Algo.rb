require 'digest/md5'
$stack = Array.new

class Graph
	def initialize()
		
	end
	def setFrom( from_predicate_term )
	end
	def findAnswers
	end
end


def go_to( target )
end

def look_for( target )
	puts "= BEGIN ==============================================================="
	puts "Looking answer for: \n\t#{target.to_s}"

	graph = Graph.new
	graph.setFrom from_predicate_term
	answers = graph.findAnswers
	
	puts "= END ================================================================="
end
