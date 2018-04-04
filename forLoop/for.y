%{
	#include<bits/stdc++.h>
	using namespace std;
	int yylex();
	int yyerror(const char *s);
	extern char *yytext;
	extern FILE *yyin;
%}
%union
{
	char *string;
}
%start START
%token <string> ID ARITHOP OPENS CLOSES OPENP CLOSEP EQUAL FOR NUM COMMA SEMI_COLON RELOP BOOLOP
%type <string> INC INIT S E START COND
%%
START	:	S 
	;
S	:	FOR OPENP INIT SEMI_COLON COND {cout<<$3<<endl; cout<<"while";cout<<"(";if($5!="")cout<<$5;cout<< ")"<<endl;} SEMI_COLON INC CLOSEP OPENS {cout<<yytext<<endl;} E  CLOSES {cout<<$8 <<endl;cout<<yytext<<endl;} E			
	|	{}
	;
E	:	S 
	|	INIT {cout<<$1;} SEMI_COLON {cout<<";"<<endl;} E
	|	INC {cout<<$1;} SEMI_COLON {cout<<";"<<endl;} E
	;
COND	: 	ID RELOP NUM BOOLOP COND {$$ = strcat($1 ,strcat( $2 ,strcat( $3 ,strcat( $4 , $5))));}
	|	ID RELOP NUM {$$ = strcat($1 ,strcat( $2 ,$3));}
	|	{$$ = (char*)"";}
	;
INIT	:	ID EQUAL NUM COMMA INIT	{strcpy($4 , ";") ;$$ = strcat($1 ,strcat( $2 ,strcat( $3 ,strcat( $4 , $5))));}
	|	ID EQUAL NUM	{$$ = strcat($1 ,strcat( $2 ,$3));strcat($$,";");}
	|	{$$ = (char*)"";}
	;
INC	:	ID ARITHOP EQUAL NUM COMMA INC {strcpy($5 , ";" ); $$ = strcat($1 ,strcat( $2 ,strcat( $3 ,strcat( $4 , strcat($5,$6)))));}
	|	ID ARITHOP EQUAL NUM {$$ = strcat($1 ,strcat( $2 ,strcat($3,$4)));strcat($$,";");}
	|	ID EQUAL ID ARITHOP NUM	  {$$ = strcat($1 ,strcat( $2 ,strcat($3,strcat($4,$5))));strcat($$,";");}
	|	ID EQUAL ID ARITHOP NUM COMMA INC {strcpy($6,";") ;$$ = strcat($1 ,strcat( $2 ,strcat( $3 ,strcat( $4 , strcat($5,strcat($6,$7))))));}
	|	{$$ = (char*)"";}
	;
%%
int yyerror(const char *s)
{
	cout<<s<<endl;
	exit(1);
}
int main()
{
	yyin = fopen("in.txt","r");
	while(!feof(yyin))
	{
		yyparse();
	}
}
