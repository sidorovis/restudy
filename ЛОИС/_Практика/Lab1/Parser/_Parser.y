%{

%}

%token SMALL_STR
%token BIG_STR
%token ENTER_S
%token END_S
%token ZAP	
%token RULE_NEXT

%%

input   :
        | input exp
;

exp :
	  fact
	;


fact
	: SMALL_STR ENTER_S END_S
	;





fact_name
	: BIG_STR
	;	

%%

