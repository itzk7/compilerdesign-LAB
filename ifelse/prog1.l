%{
	#include"y.tab.h"
	int yywrap();	
%}
%%
"if"		{yylval.string = yytext;return IF;}
"else"	{yylval.string = yytext;return ELSE;}
"("		{yylval.string = yytext;return OPEN;}
")"		{yylval.string = yytext;return CLOSE;}
"{"		{yylval.string = yytext;return OB;}
"}"		{yylval.string = yytext;return CB;}
[a-z]+	{yylval.string = yytext;return STRING;}
%%

int yywrap(void)
{
	return 1;
}
