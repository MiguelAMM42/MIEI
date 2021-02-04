#include "listas.h"

typedef struct queue {
       LInt front, last;
} Queue;

void initQueue (Queue *q);
int isEmptyQ (Queue *q);
int enqueue (Queue *q, int x);
int dequeue (Queue *q, int *x);
int front (Queue *q, int *x);
