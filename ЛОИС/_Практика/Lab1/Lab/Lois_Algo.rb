require 'digest/md5'

def param_e(a)
	tparam = a[:target]
	pparam = a[:predicate]
	return true if (tparam[0] >= "A"[0] && tparam[0] <= "Z"[0])
	return true if tparam[0] == "?"
	return true if tparam == pparam
#	puts tparam,pparam
	false
end

class BDParser::PredicateTerm
	def ==(target)
		return false if @name != target.name
		return false if @params.size != target.params.size
		(0..@params.size-1).each { |i| return false if !param_e( {:target=>target.params[i], :predicate=>@params[i]} ) }
		true
	end
end

class Graph

	def initialize()
	end

	def lookFacts( target )
		answer = Array.new
		for i in $facts
			if ( i == target )
				u = unification(target,i)
				answer.push([i,u])
			end
		end
		answer
	end

	def unification(target, predicate)
		u = Hash.new
		for i in (0..target.params.size-1)
			if !u.key?(target.params[i])
				u[ target.params[i] ] = predicate.params[i]
			else
#				puts u[ target.params[i] ],predicate.params[i],param_e({:target=>u[ target.params[i] ],:predicate=>predicate.params[i]})
				return nil if !param_e({:target=>u[ target.params[i] ],:predicate=>predicate.params[i]})
			end
		end
		u
	end

	def findAnswers( target )
		f = lookFacts( target )
		puts f
	end

end


def look_for( target )
	puts "= BEGIN ==============================================================="
	puts "Looking answer for: \n\t#{target.to_s}"
#	puts $rules.size

	graph = Graph.new
	answers = graph.findAnswers BDParser::PredicateTerm.new( target.name.clone , target.params.clone )
	
	puts "= END ================================================================="
end
