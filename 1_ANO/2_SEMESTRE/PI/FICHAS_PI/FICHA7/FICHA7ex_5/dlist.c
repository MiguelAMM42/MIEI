#include <stdio.h>
#include <stdlib.h>
#include "dlist.h"

LInt fromArray (int v[], int N){
	LInt r, *e = &r;
	int i;
	for (i=0; i<N; i++){
		*e = malloc(sizeof(struct slist));
		(*e)->valor = v[i];
		e = &((*e)->prox);
	}
	*e = NULL;
	return r;
}

void freeLInt (LInt l) {
	LInt tmp;
	while (l) {
		tmp=l; 
		l=l->prox;
		free (tmp);
	}
}

void printLInt (LInt l){
	while (l) {
		printf ("%d ", l->valor);
		l=l->prox;
	}
	putchar ('\n');
}

DLInt singular (int x){
    DLInt r = malloc (sizeof (struct dlist));
    r->valor = x;
    r->prox = r->ant = NULL;
    return r;
}

void inicio (DLInt *l){
    // ...
    DLint tmp = malloc(sizeof(struct dlist));
    tmp = l -> ant;
    freeDLint (l);
    l -> valor = tmp;
    l -> ant = l -> prox = NULL;
    
}

void fim (DLInt *l){
    DLint tmp = malloc(sizeof(struct dlist));
    tmp = l -> prox;
    freeDLint (l);
    l -> valor = tmp;
    l -> ant = l -> prox = NULL;
    // ...
}
void concat (DLInt *a, DLInt b){
    // ...    
    if (a==NULL) a -> valor = (*b);
    else (a->prox) = (*b);
    freeDLint (b);
}

LInt toLInt (DLInt l){
    // ... 
    LInt r= malloc ( sizeof(struct list));
    if (l==NULL) r = NULL;
    else{
        (r -> valor) = l -> ant;
        (r -> prox) = l -> valor;
        (r -> prox -> prox) = l -> prox;
    }
    freeDLint(l);
    return r;
}
DLInt fromLInt (LInt l){
    DLint r = malloc(sizeof(struct dlist));
    if (l==NULL) r = NULL;
    else{
        r -> ant) = l -> valor;
        r -> valor = l -> prox;
        r -> prox = l -> prox -> prox;
    }
    frreLInt (l);
    // ...    
    return r;
}

void freeDLInt (DLInt l){
    DLInt pt, tmp;
    if (l != NULL){
        pt = l->ant;
        while (pt!=NULL){
            tmp = pt; pt=pt->ant; free (tmp);
        }
        while (l!=NULL){
            tmp = l; l=l->prox; free (tmp);
        }
    }
}

void printDLInt (DLInt l){
    DLInt pt;
    if (l == NULL) printf ("Lista Vazia\n");
    else {
        printf ("Elementos esquerda: ");
        for (pt = l->ant; pt!=NULL; pt=pt->ant)
            printf ("%d ", pt->valor);
        printf ("|\nElemento actual %d\n", l->valor);
        printf ("Elementos esquerda: ");
        for (pt = l->prox; pt!=NULL; pt=pt->prox)
            printf ("%d ", pt->valor);
        printf ("|\n");
    }
}