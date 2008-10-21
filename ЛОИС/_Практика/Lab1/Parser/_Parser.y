%{

%}

%token SMALL_STR
%token BIG_STR
%token ENTER_S
%token END_S
%token ZAP	
%token RULE_NEXT
%token DOT_ZAP

%%

input   :
        | input bz
;

bz	: 	fact_list
	|	rule_list
	;

fact_list
	:	fact1 
	|	fact1 fact_list
	;

rule_list
	:	rule 
	|	rule rule_list
	;

fact1
	:	predicate_fact 
	|	equal
	;

predicate_fact
	:	predicate_name ENTER_S const_list END_S
	;

equal
	: equal_name pair_equal_names
	;

pair_equal_names
	:	pair_predicate_names
	|   pair_const_names
	;

pair_predicate_names
	:	ENTER_S	predicate_name ZAP predicate_name END_S
	;

pair_const_names
	:	ENTER_S	const_name ZAP const_name END_S
	;

rule
	: predicate_term RULE_NEXT predicate_term_list
	;

const_list
	:	const_name
	|	const_list ZAP const_name
	;

predicate_term_list
	:	predicate_term 
	|	predicate_term_list DOT_ZAP predicate_term
	;

predicate_term
	:	predicate_name ENTER_S parameter_list END_S
	;

parameter_list
	:	parameter_name 
	|	parameter_list ZAP parameter_name
	;

parameter_name
	: const_name
	| variable_name
	;

predicate_name
	:	BIG_STR
	;

variable_name
	:	BIG_STR
	;

const_name
	:	SMALL_STR
	;

equal_name
	:	SMALL_STR
	;

%%

