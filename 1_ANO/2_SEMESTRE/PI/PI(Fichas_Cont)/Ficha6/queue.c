#include <stdio.h>
#include <stdlib.h>
#include "Queue.h"

// Static queues 

void SinitQueue (SQueue q){
	// ...
	q  -> length = 0;
}

int  SisEmptyQ (SQueue q){
    // ...
	 return (q-> length == 0);
}

int  Senqueue (SQueue q, int x){
	// ...
	if(q-> front + q->length >= Max) return 1;
    else {
        q->values[q->front + q->length++] = x;
        return 0;
    }
}

int  Sdequeue (SQueue q, int *x) {
	// ...
	if(q->length == 0) return 1;
    else {
        *x = q->values[q->front + --(q->length)];
        return 0;
    }  
}

int  Sfront (SQueue q, int *x) {
	// ...
	if(q->length == 0) return 1;
    else {
        *x = q->values[q->front];
        return 0;
    }
	
	
}

void ShowSQueue (SQueue q){
    int i, p;
    printf ("%d Items: ", q->length);
    for (i=0, p=q->front; i<q->length; i++) {
        printf ("%d ", q->values[p]);
        p = (p+1)%Max;
    }
    putchar ('\n');
}

// Queues with dynamic arrays

int dupQueue (DQueue q) {
    // ...
    q ->size = size * 2; 
    return 0;
}                            ///DÚVIDAS NESTA

void DinitQueue (DQueue q) {
    q->length = 0;
    q->size = q->front ;
    q->values = malloc(q->front * sizeof(int));
}

int  DisEmptyQ (DQueue s) {
    return s -> length == 0;
}

int  Denqueue (DQueue q, int x){
    if(q->size <= q->front+ q->length) {
        q->values = realloc(q->values,2 * q->size * sizeof(int));
        q->size *= 2;
    }
    q->values[q->front + q->length++] = x;
    return 0;
}

int  Ddequeue (DQueue q, int *x){
    if(q->length == 0) return 1;
    else {
        *x = q->values[q->front + --(q->length)];
        return 0;
    }   
}

int  Dfront (DQueue q, int *x){
    if(q->length == 0) return 1;
    else {
        *x = q->values[q->front];
        return 0;
    }
    
}

void ShowDQueue (DQueue q){
    int i, p;
    printf ("%d Items: ", q->length);
    for (i=0, p=q->front; i<q->length; i++) {
        printf ("%d ", q->values[p]);
        p = (p+1)%q->size;
    }
    putchar ('\n');
}

