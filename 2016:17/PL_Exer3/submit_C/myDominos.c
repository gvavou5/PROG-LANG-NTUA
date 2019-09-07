/*
 *
  DOMINOS IN C - Vavouliotis Giorgos 03112083 / Athanasiou Nikos 03112074
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int  GlobalArr[7][8];
void Doitall(int A[7][8], int, int D[7][7],int ind2,int *);
int  Help (int A[7][8], int *, int D[7][7], int *);

int main (int argc, char *argv[]) {
    
	FILE *file;
    file = fopen(argv[1], "r");
    if (file == NULL) {
        perror("Error");
        return -1 ;
    }
    
    int i, j, result, A[7][8], D[7][7];
    
    do{
        i = j = result = 0 ;
    }while(0);
    
    do{
        j = 0 ; 
        do{
            if ( fscanf(file, "%d", &GlobalArr[i][j]) == EOF ) {
                if (ferror(file)) {
                    perror("fscanf");
                }
                else {
                    fprintf(stderr, "Error: fscanf matching failure\n");
                }
                return -1;
            }
			A[i][j] = 1;
            if (j < 7) D[i][j] = 1;
            ++j;
        }while(j < 8 );
        ++i;
    }while( i < 7 );

	Doitall(A, 0, D, 0, &result);
	printf("%d\n", result);
    
    fclose(file);
	return 0;
}

int Help (int A[7][8], int * flag, int D[7][7], int * result){
    int i, j;
    i = 0;
    do{
        j= 0 ;
        do{
            if (A[i][j] == 1){
                Doitall(A, i, D, j, result);
                *flag = 1;
            }
            if (*(flag) == 1) return 1;
            j++;
        }while(j < 8);
        if (*(flag) == 1) return 1;
        i++;
    }while(i < 8);

    return 0;
}


void Doitall(int A[7][8], int ind1, int D[7][7] , int ind2, int * result){
    
    int done,indx,indx7,indx8;
    indx  = GlobalArr[ind1][ind2];
    A[ind1][ind2] = 0;

    if ( ind2 +1 < 8 ){
        if ( A[ind1][ind2+1] == 1 ){
            indx8 = GlobalArr[ind1][ind2+1];
            if ( D[indx][indx8] == 1 ){
                done = D[indx][indx8] = D[indx8][indx] = A[ind1][ind2+1] = 0;
                if ( !Help(A, &done, D, result) ) 
                    (*result)++;
                A[ind1][ind2+1] = D[indx][indx8] = D[indx8][indx] = 1;
            }
        }
    }
    
    if ( ind1 +1 < 7 ){
        if ( A[ind1+1][ind2] == 1 ){
            indx7 = GlobalArr[ind1+1][ind2];
            if ( D[indx][indx7] == 1 ){
                done = A[ind1+1][ind2] = D[indx][indx7] = D[indx7][indx] = 0;
                if ( !Help(A, &done, D, result) ) 
                    (*result)++;
                A[ind1+1][ind2] = D[indx][indx7] = D[indx7][indx] = 1;
            }
        }
    }
    
    A[ind1][ind2] = 1;
    return;
}
