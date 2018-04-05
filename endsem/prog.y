%{
	#include<bits/stdc++.h>
	using namespace std;
	int yylex();
	int yyerror(const char *s);
	extern char *yytext;
	extern FILE *yyin;

	bool find(string);
	int sum(vector<int>);
	bool search(vector<int> , int);
	void print(vector<int>);
	map<string,vector<int> > mp;
	map<string,int>declare;
%}
%union
{
	char *string;
}
%start START
%token <string> val NAME COMMA ADD EQUAL AT INIT OR QN ASH
%type <string> S

%%
START:S
	;
S	:	INIT NAME  {				
						char *temp = $2;	
						string t(temp);
						declare[t] = true;
						mp[t].clear();
					} S
	|	AT NAME 	{
						char *temp = $2;	
						string t(temp);		
						if(find(t))
						{							
							cout<<t<<" : "<<endl;
							print(mp[t]);
						}
				
					} S
	|	INIT NAME COMMA val 	{
								char *temp = $2;
								char *temp1 = $4;
								string t(temp);	
								string t1(temp1);
								declare[t] = true;
								stringstream tt(t1);
								int x = 0;
								tt >> x;
								mp[t].push_back(x);
							} S
	|	NAME EQUAL NAME OR NAME 
						{
							char *temp = $1;	
							string t1(temp);		
							temp = $3;	
							string t2(temp);		
							temp = $5;
							string t3(temp);																								
							declare[t1] =true;
							vector<int> r;
							for(int i=0;i<mp[t2].size();i++)
							{
								r.push_back(mp[t2][i]);
							}
							for(int i=0;i<mp[t3].size();i++)
							{
								r.push_back(mp[t3][i]);
							}
							mp[t1] = r;
						}
						S
	|	NAME QN val 
					{
						char *temp = $1;	
						char *temp1 = $3;
						string t(temp);	
						string t1(temp1);
						if(find(t))
						{
							stringstream tt(t1);
							int x = 0;
							tt >> x;
							if(search(mp[t] ,x))
							{
								cout<<"found";
							}
							else
							cout<<"not found";
							cout<<endl;
						}
					} S
	|	NAME ASH NAME {
						char *temp = $1;	
						string t1(temp);		
						temp = $3;	
						string t2(temp);		
						
						if(mp[t1] == mp[t2])
						cout<<"same";
						else
						cout<<"not same";
						cout<<endl;
					}
		S
	|	ADD NAME 	{
						char *temp = $2;	
						string t(temp);						
						if(find(t))
						{
							cout<<"SUM : "<< sum(mp[t]);
							cout<<endl;
						}						
					} S
	|	{}
	;
%%
bool search(vector<int>v , int value)
{
	for(int i=0;i<v.size();i++)
	{
		if(v[i] == value)
			return true;
	}
	return false;
}
void print(vector<int> v)
{
	
	for(int i=0;i<v.size();i++)
	{
		cout<<v[i]<<" ";
	}
	cout<<endl;
}
int sum(vector<int>v)
{
	int sum = 0;
	int i = 0;
	for(i=0;i<v.size();i++)
	{
		sum+=v[i];
	}
	return sum;
}
bool find(string s)
{
	if(declare[s])
	{
		return true;
	}
	else return false;
}
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
