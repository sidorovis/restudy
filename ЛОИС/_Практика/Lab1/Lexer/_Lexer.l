%{

attr_accessor :error

#define SMALL_STR	258
#define BIG_STR		259
#define ENTER_S		260
#define END_S		261
#define ZAP		262
#define RULE_NEXT	263
#define DOT_ZAP		264
#define DOT		265
#define QUESTION	266

%}

blank   	[ \t\n]
s_letter 	[a-z]
b_letter 	[A-Z]

%%

{blank}					{ }
{s_letter}+				{ return SMALL_STR, yytext	}
{b_letter}+				{ return BIG_STR, yytext	}
"("					{ return ENTER_S, yytext	}
")"					{ return END_S, yytext		}
","					{ return ZAP, yytext		}
"<-"					{ return RULE_NEXT,yytext	}
";"					{ return DOT_ZAP, yytext	}
"."					{ return DOT, yytext		}
"?"					{ return QUESTION, yytext	}

.					{ @error="Wrong Symbol" }

%%

