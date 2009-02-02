%{
attr_reader :targets
def init_data
	@targets = Array.new
end
class Target
	attr_reader :name, :params
	def to_s
		"Target: '"+@name+"' with '"+@params.join("', '")+"'"
	end
	def initialize( name, params )
		@name, @params = name, params
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
        | target input
	;

target	:	target_term_list
	;

target_term_list
	:	target_term_list DOT_ZAP target_term
	    {	_$$ = _$1.push( _$3 )    }
	|	target_term
	    {	_$$ = [ _$1 ]   }
	;

target_term
	:	predicate_name ENTER_S target_parameter_list END_S
		{ 
			_$$ = [ _$1, _$3 ] 
			@targets.push( Target.new(_$1, _$3) )
		
		}
	;

target_parameter_list
	:	target_parameter_list ZAP target_parameter_name
	    {	_$$ = _$1.push( _$3 )    }
	|	target_parameter_name
	    {	_$$ = [ _$1 ]    }
	;

target_parameter_name
	:	QUESTION
	|	parameter_name
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

%%
