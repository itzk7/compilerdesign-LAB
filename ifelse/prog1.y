%{
	#include <stdio.h>
	extern char * yytext;
	int yylex();
	extern FILE*yyin;
	extern FILE * yyout;
	void yyerror(char*);
%}

%union
{
	char*string;
}
%token <string> STRING IF ELSE CLOSE OPEN OB CB

%start S
/*
Work only for set bracket
%%
	S	:	IF {printf("%s",yytext);} CONDITION WITHINIF E S		
		|
		;
	E	:	ELSE	{printf("%s",yytext);}
		|	{printf("%s","\telse\n");}
		;
	WITHINIF	: OB {printf("%s",yytext);} S CB {printf("%s",yytext);} 			
			|
			;
	CONDITION : OPEN {printf("%s",yytext);} STRING {printf("%s",yytext);} CLOSE	{printf("%s",yytext);}
			;
%%
*/
// Work for all cases with conflicts
%%
	S	:	OB {printf("%s",yytext);} S CB {printf("%s",yytext);} 			
		|	IF {printf("%s",yytext);} CONDITION S E S
		|	{}
		;
	E	:	ELSE	{printf("%s",yytext);} S
		|	{printf("%s","\nelse{}\n");}
		;
	CONDITION : OPEN {printf("%s",yytext);} STRING {printf("%s",yytext);} CLOSE	{printf("%s",yytext);}
			;
%%
void yyerror(char *s)
{
	printf("%s",s);
}
int main()
{
	yyin = fopen("in.txt","r");
	while(!feof(yyin))
		yyparse();	
}
