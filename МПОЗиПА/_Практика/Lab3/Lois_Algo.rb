require 'digest/md5'

def calc_time        
	0.00003
	#(0.01-(0.01/$r).abs).abs
end
def param_e(a)
	tparam = a[ :goal ]
	pparam = a[ :predicate ]
	return true if ( tparam[ 0 ] >= "A"[ 0 ] && tparam[ 0 ] <= "Z"[ 0 ] )
	return true if tparam[ 0 ] == "?"
	return true if tparam == pparam
	false
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

def ans_top(t_l)
	t_l = $t_res if $t_res < t_l
	r = rand(10)
	$t_res /= 20 if ($t_res > t_l)
	$t_res /= 1.1 while ($t_res > t_l && r > 4)
	t_l = $t_res
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
			vertex = add2front( vertex )
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
				uu = unification( goal.predicate_info , rule.to_predicate )
				if uu
					goals = Array.new
					translate = []
					e = BDParser::Equal.new("fiction",[],[])
					v = Vertex.new( e , goal, [] )
					uni = []
					for i1 in 0..rule.to_predicate.params.size-1
						uni.push( Unification.new( goal.predicate_info.params[i1] , rule.to_predicate.params[i1] ) )
					end
					v.unification = uni 
					translate.push( v )
					for what_to_prove in rule.from_predicates
						new_vertex = Vertex.new( what_to_prove, goal, [] )
						new_vertex.unification = uu
						new_vertex = add2front( new_vertex )
						goals.push( new_vertex )
					end	
				goal.goals.push( goals )
				goal.translates[ goal.goals.index(goals) ] = translate
				(0..goal.translates.size-1).each { |iii| (goal.translates[iii] = [];) unless goal.translates[iii] }
				end
			end
		end
	end
	def add2front( vertex )
		@front.push vertex
		return vertex		
	end
	
	def lookEquals( goal )
		for equal in $equals
			equal_name_a = nil
			if equal.left == goal.predicate_info.name
				equal_name_a = equal.right
			end
			if equal.right == goal.predicate_info.name
				equal_name_a = equal.left
			end
			if equal_name_a
			for rule in $rules
				if rule.to_predicate.name == equal_name_a
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
								rule_goals = make_goals(goals,names,goal, eq_vertex)
								label = false if do_next(equal_targets, indexes)
							end
						end
					end
				end
			end
		end
	end
	def make_goals( goals, equals_names, main_vertex , eq_vertex )
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
			vertex = add2front( vertex )
			for ii in 0..new_params.size-1
				e = goals[i].equal[goals[i].equal.size-1]
				equal = BDParser::Equal.new( e.name, new_params[ii], goals[i].predicate_info.params[ii] )
				vertex = Vertex.new( equal , main_vertex, [] )
				main_goals.push( vertex )
				vertex = add2front( vertex )
			end
			main_goals.push goals[i]
			add2front(goals[i])
		end
		main_vertex.goals.push main_goals
		main_vertex.translates = [] unless main_vertex.translates
		main_vertex.translates[ main_vertex.goals.size-1 ] = [eq_vertex]
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
			buildTree( vertex ) if vertex.type == :PredicateTerm || vertex.type == :Rule
			@back.push( vertex )
		end
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
	def ==(other)
		return true if @left == other.left && @right == other.right
		false
	end
end
class Vertex
	attr_reader :predicate_info, :father
	attr_accessor :goals, :type, :unification
	attr_accessor :equal, :or_goal_index, :and_goal_index, :answers
	attr_accessor :translates
	def initialize( predicate_info , father , goals, equal = Array.new )
		@current_answer = 0
		@ans_array = []
		@answers = false
		@or_goal_index = 0
		@and_goal_index = []
		@type = :PredicateTerm if predicate_info.class == BDParser::PredicateTerm
		@type = :Equal if predicate_info.class == BDParser::Equal
		@predicate_info, @father, @goals, @equal = predicate_info, father, goals, equal
		@translates = [[]]
	end
	def ==(other)
		return false if self.type == :Equal
		return false if other.type == :Equal
		self_params = self.predicate_info.params
		other_params = other.predicate_info.params
		return false if self.predicate_info.name != other.predicate_info.name
		(0..self_params.size-1).each { |i| return false if self_params[i] != other_params[i] }
	end
	def to_s()
		res = "V: "+@predicate_info.to_s+"\n father: "+((@father)?(@father.to_str):(" -no- "))+"\n type: "+@type.to_s+"\n Unification: ";
		if @unification
			@unification.each { |uni| res +=uni.left.to_s+" -> "+uni.right.to_s+" . " }
		else
			res+=" -no- "
		end
		res +="\n Equal stack: ";
		if !@equal.empty?
			res += @equal.join(". ")
		else
			res += " -no- "
		end
		res += "\n Goals:"+print_goals()+"\n Translates:"+print_trans();
		res+="\n"
	end
	def print_goals()
		res = ""
		for goal_array in @goals
			res += "\n\t"
			goal_array.each { |goal| res +=goal.to_str+". " }
		end
		res
	end
	def print_trans()
		res = ""
		for goal_array in @translates
			res += "\n\t"
			goal_array.each { |goal| res +=goal.unification.put()+". " }
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
	def next_ans_for_one(or_i)
		l = false
		while !l 
			ans = @goals[ or_i ][0].next_answer()
			break unless ans
			l, ans = test_uni_array( ans , [], or_i )
		end
		return ans
	end
	def make_pt_ind_t_e( or_i )
		t= nil
		unless t
			pt= []
			ind = []
			t = []
			e = []
			for i in @goals[ or_i ]
				if i.type != :Equal
					i.init_search()
					i.reload()
					ans = i.next_answer()
					unless ans
						return [false]*4
					end
					pt.push( ans )
					ind.push( @goals[ or_i ].index(i) )
					t.push( true )
				else
					e.push( i )
				end
			end
			t.push( true )
		else
			return false*4 unless t[ t.size-1 ]
		end # unless @t
		return pt, ind, t, e
	end
	def next_ans_for_more(pt,ind,t,e , or_i)
			return false unless t[t.size-1]
			l = false
			ans = false
			while (!l && !ans)
				ans = pt.clone
				pt[ 0 ] = @goals[ or_i ][ ind[0] ].next_answer()
				i = 1
				while ( !pt[i-1] && i <= pt.size )
					if (i >= pt.size)
						i += 1
						break
					end
					pt[i] = @goals[ or_i ][ ind[i] ].next_answer()
					@goals[ or_i ][ ind[i-1] ].init_search()
					@goals[ or_i ][ ind[i-1] ].reload()
					pt[i-1] = @goals[ or_i ][ ind[i-1] ].next_answer()
					i += 1
				end				
#				puts "! "+ans.put+"   "+i.to_s+"  "+ind.size.to_s+"    "+pt.put
				if i > ind.size
#				puts ans.put
					t[ t.size-1 ] = false
					if ans
						ans = make_u(ans)
						l,ans= test_uni_array( ans , e , or_i )
						return ans if l && ans
					end
					t = nil
					return false
				else
#				puts ans.put
					if ans
						ans = make_u(ans)
						l,ans= test_uni_array( ans , e , or_i )
						return ans if ans
					end
				end
			end
			t = nil unless ans
			return ans
	end
	def init_search()
		@or_i = 0
		@or_i = -1 if @type == :Fact
#		@current_answer = 0
		for i in @goals
			i.each { |u| u.init_search() }
		end
	end
	def reload()
#		t_s = Time.new.to_f
		Thread.critical = true
		@current_answer = 0
		Thread.critical = false
#		t_f = Time.now.to_f
#		$t_dop += t_f - t_s + calc_time
		for i in @goals
			i.each { |u| u.reload() }
		end
		
	end
	def find_answers( i, threads )
		result = false
#		t_s = Time.new.to_f
		Thread.critical = true
		if $n < $n_max
			$n += 1
#			$t += 1
			Thread.critical = false
#			t_f = Time.now.to_f
#			$t_dop += t_f - t_s + calc_time
			thread = Thread.new do
				ans = true
				if (@goals[ i ].size == 1)
					while ans
						ans = next_ans_for_one( i )
						result = true if save_ans( ans )
					end
				end
				if (@goals[ i ].size > 1)
					pt, ind, t, e = make_pt_ind_t_e( i )
					ans = true
					while ans
						ans = next_ans_for_more( pt, ind, t, e , i )
						result = true if save_ans( ans )
					end
				end
			end
#			t_s = Time.now.to_f
			Thread.critical = true
			threads.push thread
			$n -= 1
			Thread.critical = false
#			t_f = Time.now.to_f
#			$t_dop += t_f - t_s + calc_time
		else		
			ans = true
			if (@goals[ i ].size == 1)
				while ans
					ans = next_ans_for_one( i )
					result = true if save_ans( ans )
				end
			end
			if (@goals[ i ].size > 1)
				pt, ind, t, e = make_pt_ind_t_e( i )
				if t
					ans = true
					while (ans)
						ans = next_ans_for_more( pt, ind, t, e , i )
						result = true if save_ans( ans )
					end
				end
			end
		end
		return result
	end
	def next_answer()
		return false if type==:Fact && @or_i >= @goals.size
		if type == :Fact
			@or_i += 1
			return @unification
		end
		return false if @type != :PredicateTerm
		@threads = [] unless @threads
		unless @answer
#			t_s = Time.new.to_f
			@answer = true
			for i in 0..@goals.size-1
				@threads.push( [] )
				find_answers( i, @threads.last )
			end
#			t_f = Time.new.to_f
#			$t_dop += t_f - t_s
		end
		label = true
		while label 
			t_st = Time.now.to_f
			Thread.critical = true
			label = false
			@threads.each { |thread_array| thread_array.each { |thread| (label=true) if thread.status == "run" } }
			if ( @current_answer < @ans_array.size )
				label = true
				@current_answer += 1
#				t_f = Time.now.to_f
#				$t_dop += (t_f - t_st + calc_time)
#				Thread.critical = false
				return @ans_array[ @current_answer - 1 ]
			end
			Thread.critical = false
			t_f = Time.now.to_f
			$t_dop += (t_f - t_st + calc_time)
		end
		false
	end
	def save_ans(ans)
		sleep( $sleep_size )
		save_ans1(ans)
	end
	def save_ans1( ans )
		if (ans) && !(ans_exist( ans ))
#			t_s = Time.now.to_f
			Thread.critical = true
			@ans_array.push( ans.clone )
			Thread.critical = false
#			t_f = Time.now.to_f
#			$t_dop += t_f - t_s + calc_time
			return true
		end
		unless ans
#			t_s = Time.now.to_f
			Thread.critical = true
			@or_i +=1 
			t = @or_i
			@t = nil
			self.init_search()
			@or_i = t
			Thread.critical = false
#			t_f = Time.now.to_f
#			$t_dop += t_f - t_s + calc_time
		end
		return false
	end
	def ans_exist( ans )
		for a in @ans_array
			label = true
			for i in ans
				unless a.index( i )
					label = false
				end
			end
			if label
				return true
			end
		end
		false
	end
	def make_u( ans )
		u = [];
		ans.each { |i| i.each { |y| u.push( y ) } }
		u
	end
	def test_uni_array(array112,uni, or_i)
		array = array112.clone

		(0..array112.size-1).each { |i| array[i] = array112[i].clone }
		for i in 0..array.size-1
			for u in i+1..array.size-1
				return false if array[i].left == array[u].left && array[i].right != array[u].right
			end
		end
		array2 = []
		for i in array
			array2.push( i ) unless array2.include?( i )
		end
		array = array2
		for u in uni	
			for i in 0..array.size-1
				for y in 0..array.size-1
					if ( i!=y && u.predicate_info.left == array[i].left && u.predicate_info.right == array[y].left)
						return false unless find_equal(array[i].right,array[y].right)
					end
				end
			end
		end
		if self.translates.size <= or_i || self.translates[or_i].size == 0
			array.delete_if { |e| !self.predicate_info.params.include?( e.left ) }
			return true,array
		else
			i = 0
			while i < array.size
				label = false
				self.translates[or_i][0].unification.each { |u| label = true if u.right == array[i].left }
				unless label
					array.delete_at(i)
					i-=1
				end
				i+=1
			end
		end
		uni = []
		for i in 0..self.predicate_info.params.size-1
			from = self.translates[or_i][0].unification[i].right
			to = self.predicate_info.params[i]
			for u in array
				u.left = to if u.left == from
			end
		end	
		array.delete_if { |e| !self.predicate_info.params.include?( e.left ) }
		return true,array
	end
end
def find_equal(first, second)
	for equal in $equals
		return true if equal.left == first && equal.right == second
		return true if equal.left == second && equal.right == first
	end
	false
end
def look_for( goals )
	puts "= BEGIN ===============================================================" if $show_result

	goalsc = goals.clone
	$graph = Graph.new
	vertex_goals = $graph.pushGoals( goalsc )
	answers = $graph.buildGraph
	$graph.back.each { |vertex| $r += vertex.goals.size }
#	puts $graph.back
	threads = []
	for vertex_goal in vertex_goals
#		t_s = Time.new.to_f
		Thread.critical = true
		if $n < $n_max
			$n += 1
#			$t += 1
			Thread.critical = false
#			t_f = Time.now.to_f
#			$t_dop += t_f - t_s + calc_time

			thread = Thread.new do	
				vertex_goal.init_search()
				ans = vertex_goal.next_answer()
				while ans
					ans = vertex_goal.next_answer()
				end
			end
			threads.push thread
#			t_s = Time.new.to_f
			Thread.critical = true
			$n -= 1
			Thread.critical = false
#			t_f = Time.new.to_f
#			$t_dop += t_f - t_s + calc_time
		else
			Thread.critical = false
#			t_f = Time.now.to_f
#			$t_dop += t_f - t_s + calc_time
			vertex_goal.init_search()
			ans = vertex_goal.next_answer()
			while ans
				ans = vertex_goal.next_answer()
			end
		end
	end
	threads.each { |thread| thread.join }
#	puts $n
	puts "= END =================================================================" if $show_result
end
