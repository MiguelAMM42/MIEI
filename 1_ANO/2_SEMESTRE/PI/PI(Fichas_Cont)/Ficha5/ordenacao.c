#include <stdio.h>

void swap (int v[], int i, int j){
	int t=v[i];
	v[i]=v[j]; v[j]=t;
}

/////// Insertion Sort 

// Exercicio 1

void insere (int v[], int N, int x) {
    for(int i = 0; i < N; i++) {
        if(v[i] > x) {
            for(int j = N; j > i; j--) v[j] = v[j - 1];
            v[i] = x;
            break;
        }
    }
    if(v[N - 1] < x) v[N] = x;
}

// Exercicio 2

// Usando a função insere
void iSort1 (int v[], int N) {
	int i;
	for (i=1; (i<N); i++){
		insere (v, i, v[i]);
	}
}

// Semelhante ao anterior, mas sem usar a função insert
void iSort2 (int v[], int N){
	int i, x, j;
	for(i = 1; i < N; i++) {
        x = v[i];
        for(j = i; j > 0 && x < v[j - 1]; j--) v[j] = v[j - 1];
        v[j] = x;
    }
}



////// Max Sort ///////


// Exercicio 3

int maxInd (int v[], int N) {
    int ans = 0;
    for(int i = 1; i < N; i++) {
        if(v[i] > v[ans]) ans = i;
    }
    return ans;
}


// Exercicio 4

void maxSort1(int v[], int N) {
    for(int x = N; x > 0; x--) {
        int maxindx = maxInd(v,x);
        int temp = v[x - 1];
        v[x - 1] = v[maxindx];
        v[maxindx] = temp;
    }
}

// Exercicio 5

void maxSort2(int v[], int N) {
    for(int j = N; j > 0; j--) {
        int maxI = 0;
        for(int i = 1; i < j; i++)
            if(v[i] > v[maxI]) maxI = i;
        int temp = v[j - 1];
        v[j - 1] = v[maxI];
        v[maxI] = temp;
    }


////// Bubble Sort ///////

// Exercicio 6    

int bubble (int v[], int N) {
	int i, r=0;
	for (i=1; i<N; i++)
		if (v[i] < v[i-1]) {
			swap (v, i, i-1); 
			r=i;
		}
	return r; // última posição trocada
}

/*
lista = 5,3,6,4,1
i = 1
5 > 3 True
lista = 3,5,6,4,1
i = 2
5 > 6 False
i = 3
6 > 4 True
lista = 3,5,4,6,1
i = 4
6 > 1 True
lista = 3,5,4,1,6
END
*/


// Exercicio 7

void bubbleSort1(int v[], int N) {
    for(int i = 0; i < N; i++)
        bubble(v,N);
}



// Exercicio 8

int sorted(int v[], int N) {
    for(int i = 1; i < N; i++) {
        if(v[i - 1] > v[i]) return 0;
    }
    return 1;
}

void bubbleSort2(int v[], int N) {
    for(int i = 0; i < N; i++) {
        if(sorted(v,N)) break;
        else bubble(v,N);
    }
}