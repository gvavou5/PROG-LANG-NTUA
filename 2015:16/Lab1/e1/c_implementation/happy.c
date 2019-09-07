#include <stdio.h>
#include <stdlib.h>


int happy[730];
int digit_pow[10];

/* the arrays happy and digit_pow are global arrays because we
use them in the functions */

int add(int);
int happiness(int);

/* we declare the functions that we use at main() to see
the compiler that these functions exist */

int main(int argc, char* argv[])
{
    FILE* input_exer1;
    input_exer1= fopen(argv[1], "r");
	int A,B;
	fscanf(input_exer1, "%d %d", &A, &B);

	/* end of reading of txt file */

	int i,j,offset,pntr,id,ind,ind1,ind2,ind3;
	int happy1=0, happy2=0;
	int matrix[10][730],dgt[10];
	happy[0]=0;
	happy[1]=1;
	happy[2]=0;
	happy[3]=0;
	happy[4]=0;
	for (i=0;i<10;i++){
        digit_pow[i]=i*i;
		for (j=0;j<730;j++){
            if(i==0 && j >=5) happy[j]=2;
            matrix[i][j]=0;
            if(i==0 && j==0 ) matrix[i][j]=1;
		}
	}

	/* end of initialization of my arrays */

	for (i=5; i<730; i++) happy[i]=happiness(i);
	for (i=1; i<10;i++){
		for (j=0; j<=(i-1)*81; j++){
			for (offset=0; offset<10; offset++) matrix[i][j+digit_pow[offset]]+=matrix[i-1][j];
		}
	}
	ind=0;
	j=B+1;
	for (i=0;j>0;i++) {
		ind++;
		dgt[i]=j%10;
		j=j/10;
	}
	ind1=ind-1;
	id=0;
	for (i=ind1;i>=0;i--) {
		for (pntr=dgt[i]-1;pntr>=0;pntr--){
			for (j=i*81;j>=0;j--) happy1+=matrix[i][j]*happy[j+digit_pow[pntr]+id];
		}
		id+=digit_pow[dgt[i]];
	}
	ind2=0;
	j=A;
	for (i=0;j>0;i++) {
		ind2++;
		dgt[i]=j%10;
		j=j/10;
	}
	ind3=ind2-1;
	id=0;
	for (i=ind3;i>=0;i--) {
		for (pntr=dgt[i]-1;pntr>=0;pntr--){
			for (j=i*81;j>=0;j--) happy2+=matrix[i][j]*happy[j+digit_pow[pntr]+id];
		}
		id+=digit_pow[dgt[i]];
	}
	printf("%d\n", happy1-happy2);
	return 0;
}


int add(int a) {
	int tmp=0,res;
	while (a>9) {
		tmp = tmp + digit_pow[a%10];
		a = a/10;
	}
	res = tmp + digit_pow[a];
	return res;
}

int happiness(int a) {
	if (happy[a]!=2) return happy[a];
	else {
		happy[a]=happiness(add(a));
		return happy[a];
	}
}
