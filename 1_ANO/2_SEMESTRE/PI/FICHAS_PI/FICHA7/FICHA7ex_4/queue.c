#include "queue.h"

void initQueue (Queue *q){
    q = malloc(sizeof(Queue));
    q -> front = NULL;
    q -> last = NULL;
}
int isEmptyQ (Queue *q){
    if ((q -> front) == NULL) return 0;
    //...
    else return 1;
}

int enqueue (Queue *q, int x) {
    if (isEmptyQ (q)) {
        q -> last = malloc (sizeof (struct slist));
        q -> last -> valor = x;
        q -> last -> prox = NULL;
        q -> front = q -> last;
    }
    q -> last -> prox = malloc (sizeof (struct slist));
    if (!q -> last -> prox) return 1;
    q -> last -> prox -> valor = x;
    q -> last -> prox -> prox = NULL;
    q -> last = q -> last -> prox;
    return 0;
}


/*
LInt *aux;

aux = &(q->last)

aux = &(q->last->prox)
*/


int dequeue (Queue *q, int *x){
    //...
    if (!q) return 1;
    LInt tmp = 
    *x = q -> front -> valor;
    
    return -1;
}
int front (Queue *q, int *x){
    //...
    if (!q) return 1;
    *x = q -> front -> valor;
    return 0;
}
