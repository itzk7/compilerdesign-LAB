#include<bits/stdc++.h>
using namespace std;
int l = 1 , base= 1 , r = 2;
class Tree
{
	public:
	char val;
	int label , base;
	Tree *left,*right;	
	public :
		bool isoperator(char c)
		{
			if(c == '+' or c == '-' or c == '*' or c == '/')
			return true;
			return false;
		}
		Tree *create(char val)
		{
			Tree *newnode = new (Tree);
			newnode->val = val;
			newnode->left = NULL;
			newnode->right = NULL;			
			return newnode;
		}
		void inorder(Tree *root)
		{
			if(root)			
			{
				cout<<root->val<<" ";					
				inorder(root->right);						
				inorder(root->left);										
			}
		}
		void genLabel(Tree *root)
		{	
												
			if(root)						
			{	
				genLabel(root->left);						
				genLabel(root->right);
				if(!root->left and !root->right)			
				{
					root->label = 1;
					return ;
				}
				else
				{
					if(root->left->label == root->right->label)
					{
						root->label = root->left->label + 1;
					}
					else
					{
						root->label = max(root->left->label , root->right->label);
					}					
				}				
			}
		}
		void printCode(char op , int a , int base, int c)
		{
			string s;
			if(op == '+')
				s = "ADD";
			if(op == '-')
				s = "SUB";
			if(op == '%')
				s = "MOD";
			if(op == '/')
				s = "DIV";
			if(op == '*')
				s = "MUL";			
			
			cout<<s<<" R"<<a << " , R" << base<< " , R" << c<<endl;
		}
		void genCode(Tree *root , int base)
		{			
			if(!root->left and !root->right)
			{
					cout<<"LOAD R"<<base <<" , "<<root->val<<endl;
					return;
			}
				
			if(root->label <= r)
			{
				if(root->left->label == root->right->label)
				{
					genCode(root->right , base+1);
					genCode(root->left , base);
					printCode(root->val , base + root->label-1 , base + root->label-2 , base+root->label-1);
				}
				else
				{
					if(root->right->label > root->left->label)
					{
						genCode(root->right , base);
						genCode(root->left , base);
					}
					else
					{
						genCode(root->left , base);
						genCode(root->right , base);					
					}
					printCode(root->val , base + root->label-1 , base + root->left->label-1 , base + root->label-1);											
				}
			}
			else
			{
				Tree *big , *small;
				if(root->right->label > root->left->label)
				{
					small = root->right;
					big = root->left;					
				}
				else
				{
					small = root->left;
					big = root->right;
				}
				genCode(big  ,1);
				cout<<"ST t"<<root->label<<" , R"<<r<<endl;
				if(small->label < r)
					genCode(small , r - small->label);
				else
					genCode(small , base);
				cout<<"LD R"<<r-1<<" , t"<<root->label<<endl;
				if(big == root->right)
					printCode(root->val,r,r,r-1);
				else
					printCode(root->val,r,r-1,r);
			}
		}

		void genLabelBase(Tree*root)
		{	
			genLabel(root);
			genCode(root , 1);
		}
};
