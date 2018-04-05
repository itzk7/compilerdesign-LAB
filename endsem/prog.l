%{
	#include "y.tab.h" 
	#include<string.h>
	#include<stdio.h>
%}
%%
[\t\n ]+	{}

[a-z][a-zA-Z_0-9]* {yylval.string = strdup(yytext); return NAME;}

[0-9]+ {yylval.string = strdup(yytext); return val;}

"," {yylval.string = strdup(yytext); return COMMA;}

"||" {yylval.string = strdup(yytext); return OR;}

"?" {yylval.string = strdup(yytext); return QN;}

"#" {yylval.string = strdup(yytext); return ASH;}

"+" {yylval.string = strdup(yytext); return ADD;}

"=" {yylval.string = strdup(yytext); return EQUAL;}

"@" {yylval.string = strdup(yytext); return AT;}

"INIT" {yylval.string = strdup(yytext); return INIT;}

%%
