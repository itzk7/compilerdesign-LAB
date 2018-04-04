%{
	#include<bits/stdc++.h>
	#include"tree.h"
	using namespace std;
	int yylex();
	int yyerror(const char *s);	
	void process(char);
	extern char *yytext;
	extern FILE *yyin;
	stack<Tree*>s;
%}
%union
{
	char *string;
}
%start S
%token <string> ID PLUS MINUS MUL DIV OPEN CLOSE
%type <string> E T F S
%%
	S	:	E	{
					Tree * temp = s.top();					
					temp->genLabel(temp);
					temp->inorder(temp);					
					temp->genCode(temp,1);
					cout<<endl;
				}
		;
	E	:	E PLUS T {
						char *temp = $2;
						char c = *temp;
						process(c);
					}
		|	E MINUS T{
						char *temp = $2;
						char c = *temp;
						process(c);						
					}
		|	T
		;
	T	:	T MUL F{
						char *temp = $2;
						char c = *temp;
						process(c);						
					}
		|	T DIV F{
						char *temp = $2;
						char c = *temp;
						process(c);						
					}
		|	F
		;
	F	:	ID	{
					char *temp = $1;
					char c = *temp;
					process(c);					
				}
		|	OPEN E CLOSE
		;
%%
void process(char c)
{
	Tree *temp = temp->create(c);
	if(c == '+' || c == '-' || c == '*' || c == '/')
	{
		Tree *temp1 = s.top();
		s.pop();
		Tree*temp2 = s.top();
		s.pop();
		temp->left = temp1;
		temp->right = temp2;
		s.push(temp);
	}
	else
	{
		s.push(temp);
	}
}
int yyerror(const char *s)
{
	cout<<s<<endl;
	exit(1);
}
int main()
{
	yyin = fopen("in1.txt","r");
	while(!feof(yyin))
	{
		yyparse();
	}
}
