#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/* struct creation */
struct danger{
int length;
int *spntr;
};

struct node{
int *numb;
int length;
struct node *next;
};
/* end of struct creation */


/* function make_compare takes p1 and p2 and returns the true length which is an integer */
int make_compare (const void *p1, const void *p2)
{
    const struct danger *ip1 = (const struct danger *)p1;
    const struct danger *ip2 = (const struct danger *)p2;
    return (*ip1).length  - (*ip2).length;
}

/* fuction insertlist creates a new node and put it at the end of list */
struct node * insertlist (struct node * hd, int * tbl, int mhkos,struct node ** last) {
    struct node * ptr = hd;
    struct node * newnode = (struct node *)malloc(sizeof(struct node));
    newnode->numb = tbl;
    newnode->length = mhkos;
    newnode->next = NULL;
    (*last)=newnode;
    if (hd == NULL) {
        return newnode;
        /* if the list is empty then this node is the first one */
    }
    struct node * tmp = ptr;
    while (tmp->next!=NULL) tmp = tmp->next; /* run all the list and stop at the end of it */
    tmp->next = newnode;
    return ptr; /* return the head of the list */
}

/* function extract removes a node and returns the new length */
int extract (struct node ** head, int ** array) {
    if ((*head) == NULL) return 0; /* if head=NULL then the length is 0 */
    struct node * ptr = *head;
    struct node * tmp  = ptr;
    int * table = ptr->numb;
    int length = ptr->length;
    ptr = ptr->next;
    tmp->next = NULL;
    free(tmp); /* */
    (*head) = ptr;
    (*array) = table;
    return length;
}

int compare2(const void * a, const void * b)
{
   int x ;
   x=( *(int*)a - *(int*)b );
   return x;
}

/* function remove_danger removes a danger to get the rigth output*/
struct node * remove_danger(int * table,int length,struct danger bord,struct node ** last){
    int done=1;
    struct node *lst_new=NULL;
    if (bord.length>length){
        lst_new=(struct node *)malloc(sizeof(struct node));
        lst_new->numb=table;
        lst_new->length=length;
        lst_new->next=NULL;
        (*last)=lst_new;
        return lst_new;
    }
    int i;
    for (i=0;i<bord.length;i++){
        int* item = (int*) bsearch (&bord.spntr[i], table , length , sizeof (int), compare2);
        if (item==NULL){
            done=0;
        }
    }
    if (done==0){
        lst_new=insertlist(lst_new,table,length,last);
    }
    else
    {
        for (i = 0; i<bord.length; i++) {
            int * newtable = (int *)malloc((length - 1)*sizeof(int));
            int j;
            int k = 0;
            for (j = 0; j<length;j++ ){
                if (table[j]!=bord.spntr[i]){
                    newtable[k]=table[j];
                    k++;}
            }
            lst_new=insertlist(lst_new,newtable,length-1,last);

        }

    }
return lst_new;
}

/* this function does all the work*/
struct node * work_it (struct node * head, struct danger limit){
    struct node * ptr = head;
    struct node * lst_new = NULL;
    struct node * last1 = NULL;
    struct node * last2 = NULL;
    while (ptr!=NULL) {
        int * table = NULL;
        int length = extract(&ptr, &table);
        if (length!=0) {
            last1 = remove_danger(table, length, limit,&last2);

            if (lst_new == NULL) lst_new = last1;
            else {
                struct node * tmp = last1;
                while (tmp->next!=NULL)
                    tmp = tmp->next;
                tmp->next = lst_new;
                lst_new = last1;
            }
        }
    }
    return lst_new;
}


int main (int argc, char * argv[]) {
    FILE * fp = fopen(argv[1], "r"); /* start reading from txt file */
    int A,B,counter,i;
    counter=fscanf(fp, "%d %d\n", &A,&B);
    counter=counter+1;
    struct danger *limits=(struct danger *)malloc(B*sizeof(struct danger));
    for (i=0;i<B;i++){
        counter=fscanf(fp,"%d",&(limits[i].length));
        counter+=1;
        int ii;
        limits[i].spntr = (int *)malloc(limits[i].length*sizeof(int));
        for (ii= 0; ii < limits[i].length; ii++)
            counter=fscanf(fp, "%d", &limits[i].spntr[ii]);
            counter+=1;
    }
    fclose(fp) ; /* close file */
    qsort (limits, B, sizeof(struct danger), make_compare);
    struct node *head=(struct node *)malloc(sizeof(struct node));
    head->numb=(int *)malloc(A*sizeof(int));
    head->length = A;
    for (i=0;i<A;i++)
        head->numb[i]=i+1;
    head->next = NULL;
    for (i=0;i<B; i++) head = work_it(head,limits[i]);
    struct node * pntrmax = head;
    struct node * tmp = head;
    while (tmp!=NULL) {
        if ((pntrmax->length) < (tmp->length)) pntrmax = tmp;
        tmp = tmp->next;
    }
    for (i = 0; i<pntrmax->length; i++) {
            printf("%d ", pntrmax->numb[i]);
            if (i==(pntrmax->length)-1) printf("\n");
    }
    return 0;
}

