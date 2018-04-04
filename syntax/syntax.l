%{
	#include"y.tab.h"
	#include<string.h>
	#include<stdio.h>
%}
%%
[\t\n]+	{}
"+"	{yylval.string = strdup(yytext);return PLUS;}
"/"	{yylval.string = strdup(yytext);return DIV;}
"*"	{yylval.string = strdup(yytext);return MUL;}
"-"	{yylval.string = strdup(yytext);return MINUS;}
[a-z]	{yylval.string = strdup(yytext);return ID;}
"("	{yylval.string = strdup(yytext);return OPEN;}
")"	{yylval.string = strdup(yytext);return CLOSE;}
%%
