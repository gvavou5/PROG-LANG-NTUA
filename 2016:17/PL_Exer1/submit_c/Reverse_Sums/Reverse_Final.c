#include <stdio.h>
#include <stdlib.h>
#define Q 100001
#define U 10
#define Y 9
#define SUM 19
#define DM1 18


/* Authors :
 Vavouliotis Giorgos : 03112083
 Athanasiou Nikolaos : 03112074
 */


int Compute(int [],int *,int,int,int);
void complete(int *,int *,int *,int * ,int *,int *,int *);
void cmplt(int *,int *,int *,int *,int *,int *);


int main (int argc, char *argv[]) {
    FILE *file1;
    char chr,diff;
    int A_mtr[Q], B_mtr[Q], C_mtr[Q], Vltl[Q];
    int N,M,flag,i,j,diff_int,tmp,diff2,new_diff;
    
    flag = 1;
    N = 0;
    M = 0;
    file1 = fopen(argv[1], "r");
    
    
    for(;;){
        if (fscanf(file1, "%c", &chr) == 1){
            diff = chr-'0';
            if ( diff > Y) break;
            else if ( diff < 0) break;
            else{
                A_mtr[M] = diff;
                B_mtr[M] = diff;
                C_mtr[M++] = diff;
            }
        }
        else{
            printf("fscanf error\n");
            return -1;
        }
    }
    fclose(file1);
    --M;
	flag = Compute(A_mtr, Vltl, N, M, 1);
    
	if(flag!=1){
		i = N;
		j = M;
		if (B_mtr[i] == 1){
            diff_int = j - i ;
            if (diff_int == 0){
                flag = 0;
            }
            else if (diff_int == 1){
                tmp=B_mtr[1]+U;
                if (tmp%2 == 0){
                    flag = 1;
                    N = 1;
                    Vltl[1] = tmp/2;
                }
                else {
                    flag =0 ;
                }
            }
            else if (diff_int == 2){
                diff2=B_mtr[1] - B_mtr[2];
                if (diff2 == 0){
                    B_mtr[1] += U;
                    complete(&B_mtr[1],&C_mtr[1],&C_mtr[2],&Vltl[1],&Vltl[2], &flag, &N);
                }
                else if (diff2 == 1){
                    B_mtr[1] += Y;
                    complete(&B_mtr[1],&C_mtr[1],&C_mtr[2],&Vltl[1],&Vltl[2], &flag, &N);
                }
                else {
                    flag = 0;
                }
            }
            else{
                flag = 1;
                new_diff = B_mtr[++i] - B_mtr[j];
                if(new_diff == 1){
                    B_mtr[j-1]--;
                    B_mtr[i] += Y;
                    B_mtr[i+1] += U;
                }
                else if(new_diff == 0){
                    B_mtr[j-1]--;
                    B_mtr[i] += U;
                }
                else if(new_diff == -Y){
                    B_mtr[i] += Y;
                    B_mtr[i+1] += U;
                }
                else{
                    flag =0;
                }
                
                if (flag == 1){
                    cmplt(&B_mtr[i], &Vltl[i], &Vltl[j], &i, &j, &flag);
                }
                if (flag == 1){
                    flag = Compute(B_mtr, Vltl, i, j, 2);
                    if (flag != 1 ) N = 0;
                    else N = 1;
                }
            }
        }
    }
    else{
        N =0;
    }
	
    
    if (flag!=1 && flag !=2) printf("0\n");
    else{
        while(N <=M){
            printf("%d", Vltl[N++]);
            if(N > M) printf("\n");
        }
    }
    return 0;
}



void complete(int *array2,int *array31,int * array32, int * temp1, int *temp2, int *flag, int *N){
    int t;
    if((*array2 >= SUM) || (*array2 <= -1)){
        *flag = 0;
    }
    else{
        t = *array2;
        *temp1 = *array2 - t/2;
        *temp2 = t/2;
        if ((*temp1 + *temp2-U == *array32) && (*temp1 + *temp2 +1 == *array31+U)){
            *flag = 1;
            *N = 1;
        }
        else *flag = 0;
    }
}

void cmplt(int *array2, int *temp2,int *temp1, int *i, int *j, int *flag){
    int t;
    if((*array2 >= SUM) || (*array2 <= -1)){
        *flag = 0;
    }
    else{
        t = *array2;
        *temp2 = *array2 - t/2;
        *temp1 = t/2;
        *i = *i +1;
        *j = *j -1;
    }
}

int Compute(int array[], int *Vltl, int a, int b, int chr){
    int i = a, j = b,t,dif,diff1,diff2,df2;
    
    
    while(j-i > 1){
        dif =array[i] - array[j];
        if(dif == 0) ;
        else if(dif == 1){
            if ((chr == 1) && (i == 0) && (array[i] == 1)) return 0;
            array[i]--;
            array[i+1] += U;
        }
        else if(dif == U){
            array[j-1]--;
        }
        else if(dif == 11){
            array[j-1]--;
            array[i]--;
            array[i+1] += U;
        }
        else{
            return 0;
        }
        
        if((array[i] <= DM1) && (array[i] >= 0)){
            t = array[i]/2;
            Vltl[i] = array[i] - t;
            ++i;
            Vltl[j--]= t;
        }
        else return 0;
    }
    
    diff1 = j-i;
    df2 = array[i]%2 ;
    diff2 = array[i] - array[j];
    switch (diff1) {
        case 1:
            if (diff2 == (U+1)){
                array[i]--;
                if ((array[i] > DM1) || (array[i] < 0)) return 0;
                t = array[i]/2;
                Vltl[i] = array[i] - t;
                Vltl[j]= t;
                return 1;
            }
            else if (array[i] != array[j]) return 0;
            else{
                if ((array[i] > DM1) || (array[i] < 0)) return 0;
                t = array[i]/2;
                Vltl[i] = array[i] - t;
                Vltl[j]= t;
                return 1;
            }
            break;
        case 0:
            if ((df2== 0) && ((array[i] > DM1) || (array[i] < 0))) return 0;
            if (df2 == 0){
                Vltl[i] = array[i]/2;
                return 1;
            }
            else return 0;
        default:
            return 0;
            break;
    }
}