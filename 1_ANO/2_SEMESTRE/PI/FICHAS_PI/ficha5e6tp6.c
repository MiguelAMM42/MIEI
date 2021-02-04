#include <stdio.h>
#include <stdlib.h>


#define MAX 100
  typedef struct queue {
      int inicio, tamanho;
      int valores [MAX];
  } QUEUE;


// ficha 6
void initQueue (QUEUE *q) {
    q->inicio = 0; // q->inicio = MAX-1;
    q->tamanho = 0;
}

// 0 - vazio
// >0 - nao vazio
int isEmptyQ (QUEUE *q) {
    if (q->tamanho == 0)
        return 1;
    else
        return 0;
    //return !(q->tamanho); 
}

int enqueue (QUEUE *q, int x) {
    if (q->tamanho == MAX)
        return 1;
    else {
        q->valores[q->inicio + q->tamanho] = x;
        //faltou isto durante a aula
        q->tamanho++;
        //q->valores[q->inicia - q->tamanho] = x;
        return 0;
    }
}


void push(int v[], int N) {
    for (int i = 0; i < N; i++)
    {
        v[i] = v[i+1];
    }
}


int dequeue (QUEUE *q, int *x) {
    if (isEmptyQ(q))
        return 1;
    else {
        *x = q->valores[q->inicio];        
        push(q->valores, q->tamanho);
        q->tamanho--;        
        return 0;
    }
}



// aux 
void printv(int v[], int N) {
    for (int i=0;i<N; i++)
        printf("%d ", v[i]);
    printf("\n");
}

// ficha 5

void insere (int v[], int N, int x) {
    int i = N-1;
    while (x < v[i] && i >= 0) {
        v[i+1] = v[i];
        i--;
    }
    v[i+1] = x;
}


int maxInd (int v[], int N) {
    int max=v[0], maxi=0;
    for (int i = 1; i < N; i++)
    {
        if (v[i] > max) {
            max = v[i];
            maxi = i;
        }
    }
    return maxi;
}

void maxIndSort (int v[], int N) {
    int maxi, aux;
    for (int i = N-1; i > 0; i--)
    {
        // na aula faltou este +1 no i
        // o i esta a dar o indicie a usar, mas temos de 
        // passar o numero de elemento ao maxInd, ou seja, i+1
        maxi = maxInd(v, i+1);
        aux = v[i];
        v[i] = v[maxi];
        v[maxi] = aux;        
    }

}


int main(int argc, char const *argv[])
{   
    int size = 15;
    int v[15]={19, 1,33,4,5, 6, 77, 8, 9,  11,12,3,14,2};
    
    maxIndSort(v, size-1);
    printv(v, size-1);

    insere(v, size-1, -1);
    printv(v, size);


    int x;
    QUEUE *q = (QUEUE *)malloc(sizeof(QUEUE));
    initQueue(q);
    printf("is empty %d\n", isEmptyQ(q));
    printf("enqueue %d\n", enqueue(q,5));
    printf("is empty %d\n", isEmptyQ(q));
    printf("enqueue %d\n", enqueue(q,7));
    printf("dequeue %d\n", dequeue(q,&x));
    printf("x = %d\n", x);
    printf("dequeue %d\n", dequeue(q,&x));
    printf("x = %d\n", x);
    printf("is empty %d\n", isEmptyQ(q));
    printf("dequeue %d\n", dequeue(q,&x));

    return 1;
}




