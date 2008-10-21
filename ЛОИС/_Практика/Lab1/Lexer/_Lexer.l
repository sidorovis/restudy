%{

#define SMALL_STR	258
#define BIG_STR		259
#define ENTER_S		260
#define END_S		261
#define ZAP			262
#define RULE_NEXT	263

%}

blank   	[ \t\n]
s_letter 	[a-z]
b_letter 	[A-Z]

%%

{blank}					{ }
{s_letter}+				{ return SMALL_STR	}
{b_letter}+				{ return BIG_STR	}
"("						{ return ENTER_S	}
")"						{ return END_S		}
","						{ return ZAP		}
"<-"					{ return RULE_NEXT	}

.						{}

%%

