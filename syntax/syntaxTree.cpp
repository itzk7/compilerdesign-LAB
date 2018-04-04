#include<bits/stdc++.h>
using namespace std;
class Tree
{
	char val;
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
				inorder(root->left);
				inorder(root->right);				
				cout<<root->val;	
			}
		}
		Tree* constructNode(Tree *root , char c)
		{
			if(!root)
			{
				return create(c);
			}
			else if(isoperator(c))			
			{
				Tree *temp = create(c);			
				temp->left = root;
				return temp;				
			}
			else
			{
				Tree *temp = create(c);
				root->right = temp;
				return root;
			}
		}
};
int main()
{
	Tree temp;
	temp.construct("a+b*c*d");
}
