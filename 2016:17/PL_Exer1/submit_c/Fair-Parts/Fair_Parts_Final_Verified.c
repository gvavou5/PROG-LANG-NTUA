/*
Authors:
	Athanasiou Nikolaos  03112074
	Vavouliotis Georgios 03112083
*/

#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
	unsigned long long counter,athr, helper , lowerbound, upperbound , median,sum,chk;
	int i, j, weight,temp;
	int M, N;
	
	athr=0;
	lowerbound=0;
	upperbound=0;
	helper=0;

	FILE *input;
	/* 
		The exit status of the program when fscanf fails is -1.
	   	In that case appropriate message is printed.
	*/	
	input = fopen(argv[1], "r");
	if (fscanf(input, "%d %d", &M, &N)<0){
		printf("I couldn't read 2 numbers N,M something is wrong with your input!!");
		exit(-1);
	}
	
	int A[M], result[M+N-1];
	i=0;
	while(i<M){
		if (fscanf(input, "%d", &weight)<0){
		 	printf("I couldn't read n something is wrong with your input!!");
			exit(-1);
		}
		A[i] = weight;
		if (lowerbound < weight){ 
			lowerbound = weight;
		}
		athr =athr + weight;
		i++;
	}
	
	fclose(input);
	
    /** **/
	if (lowerbound < athr/N) {
	  lowerbound = athr/N;
	}
	
	if( (N != 1) && (N != M) ){
	
		for (i = 0; i < N-1; i++){
			if (upperbound < A[i]) {
				upperbound = A[i];
			}
			helper = helper + A[i];
		}
		
		if (upperbound < athr-helper){ 
			upperbound = athr-helper;
		}
		
		while (lowerbound != upperbound) {
			median = (lowerbound+upperbound)/2;
			temp=0;
			counter=0;
			sum = 0;
			
			while(temp < M){
				if (sum + A[M-temp-1] > median){
					sum = 0;
					counter++;
				}
				else{
					sum =sum+A[M-temp-1];
					temp++;
				}
			}
			
			weight = counter+1;
			
			if (weight > N){ 
				lowerbound = median+1;
				
	    		}
			else {
				upperbound = median;
			}
		}
		median = (lowerbound+upperbound)/2;
		temp=0;
		counter=0;
		sum = 0;
		while(temp < M){
			if (sum + A[M-temp-1] > median){
				sum = 0;
				counter++;
			}
			else{
				sum =sum+A[M-temp-1];
				temp++;		
			}
		}
		weight = counter+1;
		
		i = 0;
   		j = 0;
   		athr = 0;
		while( i < M ){
			chk=athr + A[M-1-i];
			if (chk <= median){
				result[M+N-2-i-j] = A[M-i-1];
				athr =athr+A[M-i-1];
				i++;
			}
			else{
				result[M+N-2-i-j] = -1;
				athr = 0;
				j++;
			}
		}
		
		j = N-weight;
		for(i=N-weight;i<M+N-1;i++){
            //printf("hello\n");
			if ((j <= 0) || (result[i] == -1) || (result[i-1] == -1) || (i == N-weight)){
				if (result[i] != -1) {
					printf("%d ", result[i]);
				}
				else {
					printf("| ");
				}
			}
			else{
				j--;
				printf("| %d ", result[i]);
			}
			
		}
	}
	else if (N==1){
        i=0;
		while (i <= M-1){
			if (i<M-1){ 
				printf("%d ", A[i]);
				i++;
			}
			else{
			 	printf("%d\n", A[M-1]);
				i++;
			}
		} 
		i--;
	}
	else{
		i=0;
		while (i <= M-1){
			if (i<M-1){
				printf("%d | ", A[i]);
				i++;
			}
			else{
				printf("%d\n", A[M-1]); 
				i++;
			}
		}
		i--;		
	}
	return 0;
}
