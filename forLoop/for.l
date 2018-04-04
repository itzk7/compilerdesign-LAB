%{
	#include "y.tab.h" 
	#include<string.h>
	#include<stdio.h>
%}
%%
[\t\n ]+	{}
";" {yylval.string = strdup(yytext); return SEMI_COLON;}
"for" {yylval.string = strdup(yytext); return FOR;}
[a-z] {yylval.string = strdup(yytext); return ID;}
[0-9]+ {yylval.string = strdup(yytext); return NUM;}
"," {yylval.string = strdup(yytext); return COMMA;}
"(" {yylval.string = strdup(yytext); return OPENP;}
")" {yylval.string = strdup(yytext); return CLOSEP;}
"{" {yylval.string = strdup(yytext); return OPENS;}
"}" {yylval.string = strdup(yytext); return CLOSES;}
[+\-*/] {yylval.string = strdup(yytext); return ARITHOP;}
"=" {yylval.string = strdup(yytext); return EQUAL;}
(<|<=|>|>=) {yylval.string = strdup(yytext); return RELOP;}
("&&"|"||") {yylval.string = strdup(yytext); return BOOLOP;}

%%
