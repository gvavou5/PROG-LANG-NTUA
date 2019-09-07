#include <stdio.h>
#include <stdlib.h>

struct node1{
	int arr[10],ind;
	struct node1* next;
};

struct  node2{
	int ind1,ind2;
	struct  node2* next;
};

typedef struct node1* node1ptr;
typedef struct node2* node2ptr;

/* functions declaration */
node1ptr nodefun1(int [10][10],int , int , int );
node2ptr nodefun2(int [10], int );
int lucky_number(int );

int main(int argc, char *argv[]){
	int numb_arr[4],i;
	/* read the input from file and store at the array named numb_arr */
	for(i=1;i<argc;i++){
            sscanf(argv[i],"%d",&numb_arr[i-1]);
	}
	/* for every given number check if is lucky and print true or false */
	for(i=0;i<argc-1;i++){
		if (lucky_number(numb_arr[i])) printf("true ");
		else printf("false ");
	}
	return 0;
}

int lucky_number(int x) {
    /* it's sure an unlucky number */
	if(x==100) return 0;
	/* it's sure a lucky number */
	if(x<10) return 1;
	int i,j,y,index;
	node1ptr l,temptr,pntr;
	node2ptr l2;
	/* each number has maximum 10 digits */
	int matrix[10][10]={{0}};
	i=0;
	y=x;
	/* take the digits of each number and put them on the array named matrix at the 1st column */
	while (y){
		matrix[i][0]=y%10;
		y=y/10;
		i++;
	}
	int length=i;
	for(j=1;j<length;j++){
		for(i=0;i<length-j;i++){
			y=1;
			for(index=i;index<=i+j;index++){
				matrix[i][j]+=matrix[index][0]*y;
				y=y*10;
			}
		}
	}
	pntr=(node1ptr)malloc(sizeof(struct node1));
	temptr=pntr;
	for(i=0;i<length;i++){
		l=nodefun1(matrix, length, 0, i);
		temptr->next=l;
		/* go to the end of list each time */
		while (temptr->next!=NULL) temptr=temptr->next;
	}
	pntr=pntr->next;
	temptr=pntr;
	while(temptr!=NULL){
		l2 = nodefun2(temptr->arr, temptr->ind);
		while(l2!=NULL){
			if(l2->ind2!=0 && (l2->ind1)/(l2->ind2) == 100) return 0;
			l2=l2->next;
		}
		temptr=temptr->next;
	}
	/* do not find any occasion that go to 100, then return 1 */
	return 1;
}

node1ptr nodefun1(int array[10][10],int length, int p1, int p2) {
	node1ptr a,b,res,c;
	a=(node1ptr)malloc(sizeof(struct node1));
	if(p1+p2==length-1){
		a->arr[0]=array[p1][p2];
		a->ind=1;
		a->next=NULL;
		return a;
	}
	int i=p1+p2+1;
	int j;
	res=(node1ptr)malloc(sizeof(struct node1));
	c=res;
	for(j=0;j<length-i;j++){
		b=nodefun1(array, length, i, j);
		a=b;
		while (a!=NULL){
			a->arr[a->ind]=array[p1][p2];
			(a->ind)++;
			a=a->next;
		}
		c->next=b;
		while(c->next!=NULL) c=c->next;
	}
	res=res->next;
	return res;
}

node2ptr nodefun2(int array[10], int p) {
	node2ptr lst,temp,i;
	if (p==0){
		lst=(node2ptr)malloc(sizeof(struct node2));
		lst->ind1=array[p];
		lst->ind2=1;
		lst->next=NULL;
		return lst;
	}
	temp=nodefun2(array,p-1);
	lst=(node2ptr)malloc(sizeof(struct node2));
	i=lst;
	while(temp!=NULL){
		lst->ind1=temp->ind1 + array[p];
		lst->ind2=temp->ind2;
		lst->next=(node2ptr)malloc(sizeof(struct node2));
		lst=lst->next;
		lst->ind1=temp->ind1 - array[p];
		lst->ind2=temp->ind2;
		lst->next=(node2ptr)malloc(sizeof(struct node2));
		lst=lst->next;
		lst->ind1=temp->ind1 * array[p];
		lst->ind2=temp->ind2;
		lst->next=(node2ptr)malloc(sizeof(struct node2));
		lst=lst->next;
		lst->ind1=temp->ind1;
		lst->ind2=temp->ind2 * array[p];
		lst->next=(node2ptr)malloc(sizeof(struct node2));
		lst=lst->next;
		temp=temp->next;
	}
	lst=NULL;
	return i;
}
