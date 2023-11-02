#include <stdlib.h> 
#define M 5   
#define N 10 
 
int T[N]; 
 
extern 
void ordena( int *tabla, int num_elem ); 
 
int main() {   
	int i,j,k;  

  	k = 1<<30;    
	srand(23456); 

 	for (i = 0;i < M;i=i+1) {     
		for (j = 0;j < N;j=j+1) {  
			T[j] = rand()-k;
		ldr	r0 , =  T[j];    
		}     
		ordena(T,N);    
	 }   
	while(1);
}