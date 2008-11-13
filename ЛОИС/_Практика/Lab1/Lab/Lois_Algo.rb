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
		return false if goal.class != Vertex
		return false if goal.predicate_info.class != BDParser::PredicateTerm
		a = self.to_predicate
		return false if a.name != goal.predicate_info.name
		return false if a.params.size != goal.predicate_info.params.size
		(0..a.params.size-1).each { |i| return false if !param_e( { :goal => goal.predicate_info.params[i] , :predicate => a.params[ i ] } ) }
		true
	end
end

class Graph
	attr_reader :back
	def initialize()
		@front = Array.new
		@back = Array.new
	end

	def pushGoals( goals )
		answer = []
		for goal in goals
			predicate_goal = BDParser::PredicateTerm.new( goal.name , goal.params )
			vertex = Vertex.new( predicate_goal, nil, [] )
			add2front( vertex )
			answer.push vertex
		end
		answer
	end

	def lookFacts( goal )
		for fact in $facts
			if ( fact == goal.predicate_info )
				u = unification( goal.predicate_info , fact )
				if u 
					new_vertex = Vertex.new( fact, goal, [] )
					new_vertex.unification = u
					new_vertex.type = :Fact
					@back.push( new_vertex )
					goal.goals.push( [new_vertex] )
				end
			end
		end
	end

	def lookRules( goal )
		for rule in $rules
			if ( rule == goal )
				u = unification( goal.predicate_info , rule.to_predicate )
				if u
					goals = Array.new
					for what_to_prove in rule.from_predicates
						new_vertex = Vertex.new( what_to_prove, goal, [] )
						new_vertex.unification = u
						add2front( new_vertex )
						goals.push( new_vertex )
					end	
				goal.goals.push( goals )
				end
			end
		end
	end
	def add2front( vertex )
		@front.push vertex if (!@front.include?( vertex ) && !@back.include?( vertex ))
	end
	
	def lookEquals( goal )
		for equal in $equals
			equal_name = nil
			if equal.left == goal.predicate_info.name
				equal_name = equal.right
			end
			if equal.right == goal.predicate_info.name
				equal_name = equal.left
			end
			if equal_name
				for rule in $rules
					if rule.to_predicate.name == equal_name
						new_params = Array.new
						for param in goal.predicate_info.params
							new_params.push param+"_"
						end
						equal_term = BDParser::PredicateTerm.new( rule.to_predicate.name, new_params )
						if equal_term == rule.to_predicate
#	место где нашли правило подход€щее под аналогию
							u = unification(equal_term, rule.to_predicate)
							eq_vertex = Vertex.new( equal_term, goal, [] )
							eq_vertex.unification = u
							eq_vertex.equal.push equal
							goals = []
							for from_predicate in rule.from_predicates
								new_params = Array.new
								for param in from_predicate.params
									new_params.push param+"_"
								end
								new_term = BDParser::PredicateTerm.new( from_predicate.name, new_params)
								vertex = Vertex.new( new_term , eq_vertex, [] )
								new_u = unification( eq_vertex.predicate_info, new_term)
								vertex.unification = new_u
								vertex.equal.push equal
								goals.push vertex
							end
							equal_targets = []
							equal_names = []
							for e_r_p_i in (0..goals.size-1)		# equal_rule_predicate_index
								equal_targets[e_r_p_i] = []
								equal_names[e_r_p_i] = []
								for equal in $equals
									equal_name = nil
									if equal.left == goals[ e_r_p_i ].predicate_info.name
										equal_name = equal.right
									end
									if equal.right == goals[ e_r_p_i ].predicate_info.name
										equal_name = equal.left
									end
									equal_targets[e_r_p_i].push equal if equal_name
									equal_names[e_r_p_i].push equal_name if equal_name
								end
							end
							indexes = []
							label = true
							(0..equal_targets.size-1).each { |ii| indexes[ii] = 0;label = false if equal_targets[ii].size == 0 }
							while label
								equals,names = do_transparent(equal_targets, indexes, equal_names)
								rule_goals = make_goals(goals,names,goal)
								label = false if do_next(equal_targets, indexes)
							end
						end
					end
				end
			end
		end
	end
	def make_goals( goals, equals_names, main_vertex )
		main_goals = []
		for i in (0..goals.size-1)
			new_params = []
			for ii in goals[i].predicate_info.params
				new_params.push ii[0,ii.size-1]
			end
			predicate = BDParser::PredicateTerm.new(  equals_names[i], new_params )
			vertex = Vertex.new( predicate, main_vertex, [] )
			vertex.unification = goals[i].unification
			vertex.equal = goals[i].equal
			main_goals.push vertex
			add2front( vertex )
			for ii in 0..new_params.size-1
				e = goals[i].equal[goals[i].equal.size-1]
				equal = BDParser::Equal.new( e.name, new_params[ii], goals[i].predicate_info.params[ii] )
				vertex = Vertex.new( equal , main_vertex, [] )
				main_goals.push( vertex )
				add2front( vertex )
			end
			main_goals.push goals[i]
			add2front(goals[i])
		end
		main_vertex.goals.push main_goals
	end
	def do_transparent( equal_targets, indexes, equal_names )
		goals = []
		goals_names = []
		for i in 0..indexes.size-1
			goals.push equal_targets[i][ indexes[i] ] 
			goals_names.push equal_names[i][ indexes[i] ] 
		end
		return goals, goals_names
	end
	def do_next( equal_targets, indexes )
		indexes[0] += 1
		i = 0
		while equal_targets[i].size == indexes[i]
			return true if i+1 == indexes.size
			indexes[i] = 0
			indexes[i + 1] += 1
			i+=1;
		end
		false
	end
	def unification( goal , predicate )
		uni = Array.new
		nil if goal.params.size != predicate.params.size
		for i in ( 0..goal.params.size-1 )
			uni[i] = Unification.new( goal.params[i], predicate.params[i] )
		end
		for i in (0..uni.size-1)
			for u in (i+1..uni.size-1)
				if 	(uni[i].left == uni[u].left && 
					(uni[i].right[0] >= 'a'[0] && uni[i].right[0] <= 'z'[0] ) &&
					(uni[u].right[0] >= 'a'[0] && uni[u].right[0] <= 'z'[0] ) &&
					uni[i].right[0] != uni[u].right[0] )
					return nil
				end
			end
		end
#		puts uni
		uni
	end
	def buildTree( goal )
		ans_facts = lookFacts( goal )
		ans_rules = lookRules( goal )
		ans_equals = lookEquals( goal )
	end
	def buildGraph
		while (!@front.empty?)
			vertex = @front[0]
			@front.delete_at( 0 )
			buildTree( vertex ) if vertex.type == :PredicateTerm
#			findEqual( vertex ) if vertex.type == :Equal
			@back.push( vertex )
		end
#		puts @back
	end
	def exist?(vertex)
		puts "Code Warning 'Graph::exist?' reserved, but not realized."
	end
end
class Unification
	attr_accessor :left, :right
	def initialize( left, right )
		@left = left
		@right = right
	end	
	def to_s()
		@left.to_s+"->"+@right.to_s
	end
end
class Vertex
	attr_reader :predicate_info, :father
	attr_accessor :goals, :type, :unification
	attr_accessor :equal, :or_goal_index, :and_goal_index, :answers
	def initialize( predicate_info , father , goals, equal = Array.new )
		@or_goal_index = 0
		@and_goal_index = []
		@type = :PredicateTerm if predicate_info.class == BDParser::PredicateTerm
		@type = :Equal if predicate_info.class == BDParser::Equal
		@predicate_info, @father, @goals, @equal = predicate_info, father, goals, equal
	end
	def ==(other)
		return true if @predicate_info == other.predicate_info
	end
	def to_s
		res = "V: "+@predicate_info.to_s+
		"\n father: "+((@father)?(@father.to_str):(" -no- "))+
		"\n type: "+@type.to_s+
		"\n Unification: "
		((@unification)?(@unification.each { |uni| res +=uni[0].to_s+" -> "+uni[1].to_s+" . " }):(res+=" -no- "))
		res +="\n Equal stack: "+((!@equal.empty?)?(@equal.join(". ")):(" -no- "))+
		"\n Goals:"+print_goals()
		res+"\n\n"
	end
	def print_goals()
		res = ""
		for goal_array in @goals
			res += "\n\t"
			goal_array.each { |goal| res +=goal.to_str+". " }
		end
		res
	end
	def to_str
		"V: "+@predicate_info.to_s
	end
	def make_ans(answers, indexes)
		ans = []
		for i in 0..answers.size-1
			ans.push( answers[i][ indexes[i] ] )
		end
		ans
	end
	def test_unification( uni, equals )
		pairs = []
		uni.get(Unification,pairs)
		for i in 0..pairs.size-1
			for u in i+1..pairs.size-1
				return false if ( pairs[i].left == pairs[u].left && pairs[i].right != pairs[u].right )
			end
		end
		true
	end
	def get_and_answers( or_index )
		answers = []
		equals = []
		for i in 0..@goals[ or_index ].size-1
			equals.push @goals[ or_index ][i].predicate_info if @goals[ or_index ][i].type == :Equals
			if @goals[ or_index ][i].type != :Equals
				answers.push(@goals[ or_index ][i].get_or_answers())
			end
		end
		indexes = Array.new( answers.size , 0 )
#		puts answers.put()
		i = 0
		label = true
		full_ans = []
		while label
			ans = make_ans(answers, indexes)
			res = test_unification( ans, equals )
			full_ans += ( ans ) if res
			indexes[0] += 1
			u = 0;
			while label && indexes[u] == answers[u].size
				if u+1 == answers.size
					label=false;
					break 
				end
				indexes[u] = 0
				indexes[u+1] += 1
				u += 1
			end
		end
#		res = test_unification( answers, equals )
		puts "!",full_ans.put()
			puts
		return full_ans
	end
	def get_or_answers()
		if @type == :Fact
			return [@unification]
		end
		puts to_str,"->"
		answers = []
		for i in 0..@goals.size-1
			answers.push self.get_and_answers( i )
		end
		
		return answers
	end
end
class Array
	def get(class_name, array)
		for i in self
			i.get(class_name,array) if i.class == Array
			array.push( i ) if i.class != Array
		end
	end
	def put()
		res = "("
		for i in self
			res += ""+i.put()+"" if i.class == Array
			res += i.to_s()+" " if i.class != Array
		end
		res += ")"
		res
	end
end
def look_for( goals )
	puts "= BEGIN ==============================================================="

	graph = Graph.new
	vertex_goals = graph.pushGoals goals
	answers = graph.buildGraph
	puts "\n\n\n\n"
	vertex_goals.each { |i| i.get_or_answers() }
	
	puts "= END ================================================================="
end
