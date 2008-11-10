require 'digest/md5'

def param_e(a)
	tparam = a[ :goal ]
	pparam = a[ :predicate ]
	return true if ( tparam[ 0 ] >= "A"[ 0 ] && tparam[ 0 ] <= "Z"[ 0 ] )
	return true if tparam[ 0 ] == "?"
	return true if tparam == pparam
	# puts tparam,pparam
	false
end

class BDParser::PredicateTerm
	def ==( goal )
		return false if goal.class != BDParser::PredicateTerm
		return false if @name != goal.name
		return false if @params.size != goal.params.size
		(0..@params.size-1).each { |i| return false if !param_e( { :goal => goal.params[i] , :predicate => @params[ i ] } ) }
		true
	end
end
class BDParser::Rule
	def ==( goal )
		return false if goal.class != BDParser::PredicateTerm
		a = self.to_predicate
		return false if a.name != goal.name
		return false if a.params.size != goal.params.size
		(0..a.params.size-1).each { |i| return false if !param_e( { :goal => goal.params[i] , :predicate => a.params[ i ] } ) }
		true
	end
end

class Graph

	def initialize()
		@front = Array.new
		@back = Array.new
	end

	def pushGoals( goals )
		for goal in goals
			predicate_goal = BDParser::PredicateTerm.new( goal.name , goal.params )
			@front.push( Vertex.new( predicate_goal, nil, [] ) )
		end
	end

	def lookFacts( goal )
		answer = Array.new
		for i in $facts
			if ( i == goal.predicate_info )
				u = unification( goal.predicate_info , i )
				answer.push( [ i , u ] ) if u
			end
		end
		answer
	end

	def lookRules( goal )
		answer = Array.new
		for i in $rules
			if ( i == goal )
#				puts "! "+i.to_s
				u = unification( goal , i.to_predicate )
				if u
#					for what_to_prove in from_predicates
#						@front.push( Vertex.new( what_to_prove , goal , [] )						
#					end	
#					puts u
				end
			end
		end
		answer
	end

	def unification( goal , predicate )
		u = Hash.new
		for i in ( 0..goal.params.size-1 )
			if !u.key?( goal.params[ i ] )
				u[ goal.params[ i ] ] = predicate.params[i]
			else
				# puts u[ goal.params[i] ],predicate.params[i],param_e({:goal=>u[ goal.params[i] ],:predicate=>predicate.params[i]})
				return nil if !param_e( { :goal => u[ goal.params[i] ] , :predicate => predicate.params[i] } )
			end
		end
		return nil if u.keys.size != predicate.params.size
		u
	end

	def findAnswer( goal )
		ans = lookFacts( goal )
		ans
	end

	def findAnswers
		while (!@front.empty?)
			vertex = @front[0]
			@front.delete_at( 0 )
			ans = findAnswer( vertex )
			for uni in ans
				new_vertex = Vertex.new(  )
				@back.push(  )
				vertex.goals.push()
			end
			ans.each { |unification|  }

			vertex.unification = ans[1]
			@back.push( vertex )
		end
		puts @back
	end
	def exist?(vertex)
		puts "Code Warning 'Graph::exist?' reserved, but not realized."
	end
end

class Vertex
	attr_reader :predicate_info, :father
	attr_accessor :goals, :type, :unification
	def initialize( predicate_info , father , goals )
		@type = :PredicateTerm if predicate_info.class == BDParser::PredicateTerm
		@type = :Equal if predicate_info.class == BDParser::Equal
#		@type = :Unification if predicate_info.class == Unification
		@predicate_info, @father, @goals = predicate_info, father, goals
	end
	def ==(other)
		return true if @predicate_term == other.predicate_term
	end
	def to_s
		"Vertex: "+@predicate_info.to_s+
		",\n father: "+((@father)?@father:" -no- ")+
		",\n type: "+@type.to_s+
		",\n Unification: "+((@unification)?(@unification.to_s):(" -no- "))+
		"\n Goals: '"+((@goals && !@goals.empty?)?("\n\t"+@goals.join("\n\t")):" -no- ")+"'"
	end
end

def look_for( goals )
	puts "= BEGIN ==============================================================="

	graph = Graph.new
	graph.pushGoals goals
	answers = graph.findAnswers
	
	puts "= END ================================================================="
end
