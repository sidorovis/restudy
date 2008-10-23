%{
attr_reader :equals, :facts, :rules
def init_data
	@equals = Array.new
	@facts = Array.new
	@rules = Array.new
end
class Equal
	def to_s
		"Equalitation: '"+@name+"' of ('"+@left+"' <=> '"+@right+"')"
	end
	def initialize(name, left, right)
		@name, @left, @right = name, left, right
	end
end
class Fact
	def to_s
		"Fact: '"+@name+"' of ('"+@params.join("', '")+"')"
	end
	def initialize(name, params)
		@name, @params = name, params
	end
end
class PredicateTerm
	def to_s
		"'"+@name+"' ( '"+@params.join("', '") +"' )"
	end
	def initialize(name,params)
		@name, @params = name, params
	end
end
class Rule
    	def to_s
    		"Rule: get \""+@to_predicate.to_s+"\" from "+"\""+@from_predicates.join("\", \"")+"\""
    	end
    	def initialize(to_predicate, from_predicates_datas)
        		@from_predicates = Array.new
        		from_predicates_datas.each { |i| @from_predicates.push( PredicateTerm.new( i[0], i[1] ) ) }
        		@to_predicate = PredicateTerm.new( to_predicate[0], to_predicate[1] )
	end
end

%}

%token SMALL_STR
%token BIG_STR
%token ENTER_S
%token END_S
%token ZAP	
%token RULE_NEXT
%token DOT_ZAP
%token DOT
%token QUESTION

%%

input   :
        | bz input
	;

bz	:	fact DOT
	|	rule DOT
	;

fact	:	predicate_fact
	|	equal
	;

predicate_fact
	:	predicate_name ENTER_S const_list END_S
	    {	
		_$$ = [ _$1, _$3 ]    
		@facts.push( Fact.new(_$1, _$3) )
	    }
	;

equal	:	equal_name ENTER_S pair_equal_name END_S
	    {	
		_$$ = [ _$1, _$3 ]    
		@equals.push( Equal.new(_$1,_$3[0], _$3[1]) )
	    }
	;

pair_equal_name
	:	pair_const_name
	    {	_$$ = _$1    }
	|	pair_predicate_name
	    {	_$$ = _$1    }
	;

pair_const_name
	:	const_name ZAP const_name
	    {	_$$ = [ _$1, _$3 ]    }
	;

pair_predicate_name
	:	predicate_name ZAP predicate_name
	    {	_$$ = [ _$1, _$3 ]    }
	;

rule	:	predicate_term RULE_NEXT predicate_term_list
	    {	
		_$$ = [ _$1, _$3 ]    
		@rules.push( Rule.new( _$1 , _$3 ) )
	    }
	;

const_list
	:	const_list ZAP const_name
	    {	_$$ = _$1.push( _$3 )    }
	|	const_name
	    {	_$$ = [ _$1 ]    }
	;

predicate_term_list
	:	predicate_term_list DOT_ZAP predicate_term
	    {	_$$ = _$1.push( _$3 )    }
	|	predicate_term
	    {	_$$ = [ _$1 ]    }
	;

predicate_term
	:	predicate_name ENTER_S parameter_list END_S
	    {
		_$$ = [ _$1, _$3 ]
	    }
	;

parameter_list
	:	parameter_list ZAP parameter_name
	    {	_$$ = _$1.push( _$3 )    }
	|	parameter_name 
	    {	_$$ = [ _$1 ]    }
	;

parameter_name
	: const_name
	| variable_name
	;

predicate_name
	:	BIG_STR { predicate_name = yylval }
	;

variable_name
	:	BIG_STR { variable_name = yylval }
	;

const_name
	:	SMALL_STR { const_name = yylval }
	;

equal_name
	:	SMALL_STR { equal_name = yylval }
	;

%%
